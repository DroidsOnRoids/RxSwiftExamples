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
            .flatMap { name in
                return self.findRepository(name)
            }
            .flatMap { repository in
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
    }
    
    internal func findRepository(name: String) -> Observable<Repository> {
        return self.provider
            .request(GitHub.Repo(fullName: name))
            .debug()
            .mapObject(Repository.self)
    }
    
}