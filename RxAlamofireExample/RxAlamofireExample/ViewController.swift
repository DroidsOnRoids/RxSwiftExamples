//
//  ViewController.swift
//  RxAlamofireExample
//
//  Created by Lukasz Mroz on 10.02.2016.
//  Copyright © 2016 Droids on Roids. All rights reserved.
//

import UIKit
import ObjectMapper
import RxAlamofire
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    let disposeBag = DisposeBag()
    var repos = [Repository]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRx()
        setupUI()
    }

    func setupRx() {
        searchBar.rx_text
            .filter { $0.characters.count > 0 }
            .distinctUntilChanged()
            .throttle(0.5, scheduler: MainScheduler.instance)
            .subscribeNext { text in
                RxAlamofire
                    .requestJSON(.GET, "https://api.github.com/users/\(text)/repos")
                    .observeOn(MainScheduler.instance)
                    .debug()
                    .subscribeNext { (response, json) in
                        if let repos = Mapper<Repository>().mapArray(json) {
                            self.repos = repos
                        }
                    }
                    .addDisposableTo(self.disposeBag)
            }
            .addDisposableTo(disposeBag)
    }
    
    func setupUI() {
        tableView.dataSource = self
    }
    
}

extension ViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("repositoryCell", forIndexPath: indexPath)
        cell.textLabel?.text = repos[indexPath.row].name
        return cell
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repos.count
    }
    
}

