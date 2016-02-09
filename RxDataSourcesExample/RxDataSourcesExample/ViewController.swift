//
//  ViewController.swift
//  RxDataSourcesExample
//
//  Created by Lukasz Mroz on 08.02.2016.
//  Copyright © 2016 Droids on Roids. All rights reserved.
//
//
//  This is basically the copy of RxSwiftExample, but using RxDataSources and NSObject-Rx,
//  from the awesome RxSwiftCommunity. The first module, RxDataSources, allows to easily
//  use blocks and bind them to table views instead of using large delegate methods. The
//  second one, NSObject-Rx, is just a wrapper that you don't have to everytime write
//  DisposableBags, Rx will take care of it for you!
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import NSObject_Rx

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    let dataSource = RxTableViewSectionedReloadDataSource<DefaultSection>()
    var shownCitiesSection: DefaultSection!
    var allCities = [String]()
    var sections = Variable([DefaultSection]())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        allCities = ["New York", "London", "Oslo", "Warsaw", "Berlin", "Praga"]
        shownCitiesSection = DefaultSection(header: "Cities", items: allCities.toItems(), updated: NSDate())
        sections.value = [shownCitiesSection]
        dataSource.configureCell = { (tableView, indexPath, index) in
            let cell = tableView.dequeueReusableCellWithIdentifier("cityPrototypeCell", forIndexPath: indexPath)
            cell.textLabel?.text = self.shownCitiesSection.items[indexPath.row].title
            return cell
        }
        
        sections
            .asObservable()
            .bindTo(tableView.rx_itemsWithDataSource(dataSource))
            .addDisposableTo(rx_disposeBag) // Instead of creating the bag again and again, use the extension NSObject_rx
        searchBar
            .rx_text
            .throttle(0.5, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .subscribeNext { [unowned self] (query) in
                let items: [String]
                if query.characters.count > 0 {
                    items = self.allCities.filter { $0.hasPrefix(query) }
                } else {
                    items = self.allCities
                }
                self.shownCitiesSection = DefaultSection(
                    original: self.shownCitiesSection,
                    items: items.toItems()
                )
                self.sections.value = [self.shownCitiesSection]
            }
            .addDisposableTo(rx_disposeBag)
    }

}

extension CollectionType where Self.Generator.Element == String {
    func toItems() -> [DefaultItem] {
        return self.map { DefaultItem(title: $0, dateChanged: NSDate()) }
    }
}
