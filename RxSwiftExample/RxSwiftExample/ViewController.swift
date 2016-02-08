//
//  ViewController.swift
//  RxSwiftExample
//
//  Created by Lukasz Mroz on 08.02.2016.
//  Copyright © 2016 Droids on Roids. All rights reserved.
//
//
//
// Here we have basic example of RxSwift. UI is pretty simple, take a look at Main.storyboard.
// It is basically UISearchBar + UITableView. The main idea of this app is that every time
// someone types something in the search bar, we want to get the cities from API that starts
// with the letters someone typed. The main problems here are:
// a) What if the text(here query) in search bar is empty?
// b) What if someone will spam API by continuesly changing letters?
//
// We want to be safe with our app so we will filter the empty queries to protect against a).
// About the b), we will use RxSwift's throttle() & distinctUntilChanged(). The first one
// waits given time for a change. If the change occured before the time given, timer will reset
// and Rx will wait again for a change. If change didn't happen in specified time, the next value
// will go through. Basically it means that we will wait X time before sending API request, if someone
// changed his mind (or just spam), we will wait patiently. If not, we will just do the API request.
// Second function distinctUntilChanged() will protect us against searching the same phrase again.
// So if someone type A, then will type AB and go back to A, we will not fire another request (it is
// just in our case that we want that behavior, if you have dynamically changed fields, you better
// leave this function).
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var shownCities = [String]() // Here we have the data source for UITableView
    var allCities = [String]() // This will be our mocked API data source
    let disposeBag = DisposeBag() // Bag of disposables to release them after view is released (protect against retain cycle)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        tableView.dataSource = self
        allCities = ["New York", "London", "Oslo", "Warsaw", "Berlin", "Praga"]
        searchBar
            .rx_text // Observable property thanks to RxCocoa
            .throttle(0.5, scheduler: MainScheduler.instance) // Wait 0.5 for changes.
            .distinctUntilChanged() // If they didn't occur, check if the new value is the same as old.
            .filter { $0.characters.count > 0 } // If the new value is really new, filter for non-empty query.
            .subscribeNext { [unowned self] (query) in // Here we subscribe to every new value, that is not empty (thanks to filter above).
                self.shownCities = self.allCities.filter { $0.hasPrefix(query) } // We now do our "API Request" to find cities.
                self.tableView.reloadData() // And reload table view data.
            }
            .addDisposableTo(disposeBag) // Don't forget to add this to disposeBag to avoid retain cycle.
    }
    
}

// MARK: - UITableViewDataSource
/// Here we have standard data source extension for ViewController
extension ViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shownCities.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cityPrototypeCell", forIndexPath: indexPath)
        cell.textLabel?.text = shownCities[indexPath.row]
        return cell
    }
    
}