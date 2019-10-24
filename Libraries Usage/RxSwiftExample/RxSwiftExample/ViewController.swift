//
//  ViewController.swift
//  RxSwiftExample
//
//  Created by Lukasz Mroz on 08.02.2016.
//  Copyright © 2016 Droids on Roids. All rights reserved.
//
//
//
//  Here we have basic example of RxSwift. UI is pretty simple, take a look at Main.storyboard.
//  It is basically UISearchBar + UITableView. The main idea of this app is that every time
//  someone types something in the search bar, we want to get the cities from API that starts
//  with the letters someone typed. The main problems here are:
//  a) What if the text(here query) in search bar is empty?
//  b) What if someone will spam API by continuesly changing letters?
//
//  We want to be safe with our app so we will filter the empty queries to protect against a).
//  About the b), we will use RxSwift's debounce() & distinctUntilChanged(). The first one
//  waits given time for a change. If the change occured before the time given, timer will reset
//  and Rx will wait again for a change. If change didn't happen in specified time, the next value
//  will go through. Basically it means that we will wait X time before sending API request, if someone
//  changed his mind (or just spam), we will wait patiently. If not, we will just do the API request.
//  Second function distinctUntilChanged() will protect us against searching the same phrase again.
//  So if someone type A, then will type AB and go back to A, we will not fire another request (it is
//  just in our case that we want that behavior, if you have dynamically changed fields, you better
//  leave this function).
//

import UIKit
import RxCocoa
import RxSwift

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var shownCities = [String]() // Data source for UITableView
    let allCities = ["New York", "London", "Oslo", "Warsaw", "Berlin", "Praga"] // Our mocked API data source
    let disposeBag = DisposeBag() // Bag of disposables to release them when view is being deallocated
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        tableView.dataSource = self
        searchBar
            .rx.text // Observable property thanks to RxCocoa
            .orEmpty // Make it non-optional
            .debounce(.milliseconds(500), scheduler: MainScheduler.instance) // Wait 0.5 for changes.
            .distinctUntilChanged() // If they didn't occur, check if the new value is the same as old.
            .filter { !$0.isEmpty } // If the new value is really new, filter for non-empty query.
            .subscribe(onNext: { [unowned self] query in // Here we subscribe to every new value, that is not empty (thanks to filter above).
                self.shownCities = self.allCities.filter { $0.hasPrefix(query) } // We now do our "API Request" to find cities.
                self.tableView.reloadData() // And reload table view data.
            })
            .disposed(by: disposeBag) // Don't forget to add this to disposeBag. We want to dispose it on deinit.
    }
    
}

// MARK: - UITableViewDataSource
/// Here we have standard data source extension for ViewController
extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shownCities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cityPrototypeCell", for: indexPath)
        cell.textLabel?.text = shownCities[indexPath.row]
        cell.textLabel?.textColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
        
        return cell
    }
}
