//
//  RepositoryNetworkModel.swift
//  RxAlamofireExample
//
//  Created by Lukasz Mroz on 25.04.2016.
//  Copyright © 2016 Droids on Roids. All rights reserved.
//

import ObjectMapper
import RxAlamofire
import RxCocoa
import RxSwift

struct RepositoryNetworkModel {
    
    lazy var rx_repositories: Driver<[Repository]> = self.fetchRepositories()
    private var repositoryName: Observable<String>
    
    init(withNameObservable nameObservable: Observable<String>) {
        self.repositoryName = nameObservable
    }
    
    private func fetchRepositories() -> Driver<[Repository]> {
        return repositoryName
            .subscribeOn(MainScheduler.instance) // Make sure we are on MainScheduler
            .doOn(onNext: { response in
                UIApplication.sharedApplication().networkActivityIndicatorVisible = true
            })
            .observeOn(ConcurrentDispatchQueueScheduler(globalConcurrentQueueQOS: .Background))
            .flatMapLatest { text in // .Background thread, network request
                return RxAlamofire
                    .requestJSON(.GET, "https://api.github.com/users/\(text)/repos")
                    .debug()
                    .catchError { error in
                        return Observable.never()
                    }
            }
            .observeOn(ConcurrentDispatchQueueScheduler(globalConcurrentQueueQOS: .Background))
            .map { (response, json) -> [Repository] in // again back to .Background, map objects
                if let repos = Mapper<Repository>().mapArray(json) {
                    return repos
                } else {
                    return []
                }
            }
            .observeOn(MainScheduler.instance) // switch to MainScheduler, UI updates
            .doOn(onNext: { response in
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
            })
            .asDriver(onErrorJustReturn: []) // This also makes sure that we are on MainScheduler
    }
}