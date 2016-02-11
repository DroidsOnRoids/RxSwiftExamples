//
//  IssueTrackerModel.swift
//  RxMoyaExample
//
//  Created by Lukasz Mroz on 11.02.2016.
//  Copyright © 2016 Droids on Roids. All rights reserved.
//

import Foundation
import Moya
import Moya_ModelMapper
import RxSwift

protocol IssueTrackerModelType {
    var repositoryName: Observable<String> { get }
    var provider: RxMoyaProvider<GitHub> { get }
    
    func findIssues(repository: Repository)
}

struct IssueTrackerModel: IssueTrackerModelType {
    
    let provider = RxMoyaProvider<GitHub>()
    let repositoryName: Observable<String>
    
    func findIssues(repository: Repository) {
        
    }
    
    func findRepository(name: String) -> Observable<Repository> {
        return self.provider
            .request(GitHub.Repo(fullName: name))
            .mapObject(Repository.self)
    }
    
}