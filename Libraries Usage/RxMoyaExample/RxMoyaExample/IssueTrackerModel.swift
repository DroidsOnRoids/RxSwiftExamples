//
//  IssueTrackerModel.swift
//  RxMoyaExample
//
//  Created by Lukasz Mroz on 11.02.2016.
//  Copyright © 2016 Droids on Roids. All rights reserved.
//

import Foundation
import Moya
import Mapper
import Moya_ModelMapper
import RxOptional
import RxSwift

struct IssueTrackerModel {
    
    let provider: MoyaProvider<GitHub>
    let repositoryName: Observable<String>
    
    func trackIssues() -> Observable<[Issue]> {
        return repositoryName
            .observeOn(MainScheduler.instance)
            .flatMapLatest { name -> Observable<Repository?> in
                print("Name: \(name)")
                return self
                    .findRepository(name)
            }
            .flatMapLatest { repository -> Observable<[Issue]?> in
                guard let repository = repository else {
                    return Observable.just(nil)
                }
                
                print("Repository: \(repository.fullName)")
                return self.findIssues(repository)
            }
            .replaceNilWith([])
    }
    
    internal func findIssues(_ repository: Repository) -> Observable<[Issue]?> {
        return self.provider.rx
            .request(GitHub.issues(repositoryFullName: repository.fullName))
            .debug().asObservable()
            .mapOptional(to: [Issue].self)
    }

    internal func findRepository(_ name: String) -> Observable<Repository?> {
        return self.provider.rx
            .request(GitHub.repo(fullName: name))
            .debug().asObservable()
            .mapOptional(to: Repository.self)
    }
}
