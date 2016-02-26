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
import RxSwift

protocol IssueTrackerModelType {
    var repositoryName: Observable<String> { get }
    var provider: RxMoyaProvider<GitHub> { get }
    
    func findIssues(repository: Repository) -> Observable<[Issue]>
}

struct IssueTrackerModel: IssueTrackerModelType {
    
    let provider: RxMoyaProvider<GitHub>
    let repositoryName: Observable<String>
    
    func trackIssues() -> Observable<[Issue]> {
        return repositoryName
            .observeOn(MainScheduler.instance)
            .flatMapLatest { name -> Observable<Repository> in
                print("Name: \(name)")
                return self.findRepository(name)
            }
            .flatMapLatest { repository -> Observable<[Issue]> in
                print("Repository: \(repository.fullName)")
                return self.findIssues(repository)
            }
    }
    
    internal func findIssues(repository: Repository) -> Observable<[Issue]> {
        // We could do this on repository name, but just to show chaining
        // we will use whole Repository object
        return self.provider
            .request(GitHub.Issues(repositoryFullName: repository.fullName))
            .debug()
            .mapArray(Issue.self)
            .catchError { error in
                print("Error! \(error)")                
                return Observable.just([])
            }
    }
    
    internal func findRepository(name: String) -> Observable<Repository> {
        return self.provider
            .request(GitHub.Repo(fullName: name))
            .debug()
            .mapObject(Repository.self)
            .catchError { error in
                print("Error! \(error)")
                return Observable.never()
            }
    }
    
}