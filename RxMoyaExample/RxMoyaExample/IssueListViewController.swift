//
//  ViewController.swift
//  RxMoyaExample
//
//  Created by Lukasz Mroz on 10.02.2016.
//  Copyright © 2016 Droids on Roids. All rights reserved.
//

import Moya
import Moya_ModelMapper
import UIKit
import RxCocoa
import RxSwift

class IssueListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    let disposeBag = DisposeBag()
    var provider: RxMoyaProvider<GitHub>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRx()
    }
    
    func setupRx() {
//        let endpointClosure: GitHub -> Endpoint<GitHub> = { (target: GitHub) -> Endpoint<GitHub> in
//            return Endpoint<GitHub>(URL: self.url(target), sampleResponseClosure: {.NetworkResponse(200, target.sampleData)}, method: target.method, parameters: target.parameters)
//        }
//        provider = RxMoyaProvider(endpointClosure: endpointClosure)
        provider = RxMoyaProvider()
    }
    
    func getLatestRepositoryName() -> Observable<String> {
        return searchBar
            .rx_text
            .throttle(0.3, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
    }

    func url(route: TargetType) -> String {
        return route.baseURL.URLByAppendingPathComponent(route.path).absoluteString
    }
    
}

