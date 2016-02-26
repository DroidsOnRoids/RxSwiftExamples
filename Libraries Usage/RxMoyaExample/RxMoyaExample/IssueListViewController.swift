//
//  ViewController.swift
//  RxMoyaExample
//
//  Created by Lukasz Mroz on 10.02.2016.
//  Copyright © 2016 Droids on Roids. All rights reserved.
//
//
//  In this project we take more advanced steps, but still quite simple,
//  to make working with network layer even more smooth and nice than
//  before. Now, with use of Moya/RxSwift/ModelMapper, we will create simple
//  model that will handle our logic and we will do everything based on
//  Observables. First there is our observable text, which we will cover
//  as a computed var to pass it as an observable. Now every time we got a 
//  signal that the name in the searchbar changed, we will filter it and 
//  chain with additional steps. First of them would be to call github api
//  to verify that the repo exists. If yes, we pass the signal as next
//  observable to get the repo issues. Now that we have whole chain
//  at the end of the chain if everything worked correctly, we now can 
//  bind our observable to table view and store it in the cell factory.
//  With really little code we have setup really complicated logic, but
//  what is more important is that we have done it really smooth, really
//  nice and if you have a little bit more experience with Rx, it gets
//  really readable.
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
    var issueTrackerModel: IssueTrackerModel!
    
    var latestRepositoryName: Observable<String> {
        return searchBar
            .rx_text
            .throttle(0.5, scheduler: MainScheduler.instance)
            .filter { $0.characters.count > 0 }
            .distinctUntilChanged()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRx()
    }
    
    func setupRx() {
        provider = RxMoyaProvider<GitHub>()
        issueTrackerModel = IssueTrackerModel(provider: provider, repositoryName: latestRepositoryName)
        issueTrackerModel
            .trackIssues()
            .bindTo(tableView.rx_itemsWithCellFactory) { (tv, row, item) in
                let cell = tv.dequeueReusableCellWithIdentifier("issueCell", forIndexPath: NSIndexPath(forRow: row, inSection: 0))
                cell.textLabel?.text = item.title
                
                return cell
            }
            .addDisposableTo(disposeBag)
    }

    func url(route: TargetType) -> String {
        return route.baseURL.URLByAppendingPathComponent(route.path).absoluteString
    }
    
}

