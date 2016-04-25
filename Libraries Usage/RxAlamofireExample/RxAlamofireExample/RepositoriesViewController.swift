//
//  RepositoriesViewController.swift
//  RxAlamofireExample
//
//  Created by Lukasz Mroz on 10.02.2016.
//  Copyright © 2016 Droids on Roids. All rights reserved.
//
//
//  In this app we connect few libraries to make repository search
//  through GitHub API. Lets split it for few steps.
//  First step would be to setup RxSwift so we can observe text
//  from UISearchBar and get the updates. When we get the update,
//  we have to make sure we are not spamming API. So we will make
//  use of throttle(_:scheduler) and distinctUntilChanged(). Also
//  remember to use it in the same order as in the example (to make
//  sure you get updates from the main thread always, because
//  otherwise distinct might not work correctly). Then the next step
//  would be to get the actual query from UISearchBar and now, that
//  we know that we will not spam API, we can make a Alamofire
//  request. To do it, we will also use RxSwift, now with the
//  RxAlamofire wrapper. It makes using Alamofire nice and clean,
//  as you can see in the code. We will make a requst to GitHub
//  API and fetch the request for given username. To parse json
//  array into Repository objects we will use ObjectMapper here.
//  And thats it! Not that hard, right? Oh, and also be careful 
//  about Schedulers. :wink:
//

import UIKit
import ObjectMapper
import RxAlamofire
import RxCocoa
import RxSwift

class RepositoriesViewController: UIViewController {
    
    @IBOutlet weak var tableViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    let disposeBag = DisposeBag()
    var repositoryNetworkModel: RepositoryNetworkModel!
    
    var rx_searchBarText: Observable<String> {
        return searchBar
            .rx_text
            .filter { $0.characters.count > 0 }
            .throttle(0.5, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRx()
    }
    
    func setupRx() {
        repositoryNetworkModel = RepositoryNetworkModel(withNameObservable: rx_searchBarText)
        
        repositoryNetworkModel
            .rx_repositories
            .drive(tableView.rx_itemsWithCellFactory) { (tv, i, repository) in
                let cell = tv.dequeueReusableCellWithIdentifier("repositoryCell", forIndexPath: NSIndexPath(forRow: i, inSection: 0))
                cell.textLabel?.text = repository.name
                
                return cell
            }
            .addDisposableTo(disposeBag)
        
        repositoryNetworkModel
            .rx_repositories
            .driveNext { repositories in
                if repositories.count == 0 {
                    let alert = UIAlertController(title: ":(", message: "No repositories for this user.", preferredStyle: .Alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
                    if self.navigationController?.visibleViewController?.isMemberOfClass(UIAlertController.self) != true {
                        self.presentViewController(alert, animated: true, completion: nil)
                    }
                }
            }
            .addDisposableTo(disposeBag)
    }
    
    func setupUI() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(tableTapped(_:)))
        tableView.addGestureRecognizer(tap)
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: #selector(keyboardWillShow(_:)),
            name: UIKeyboardWillShowNotification,
            object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: #selector(keyboardWillHide(_:)),
            name: UIKeyboardWillHideNotification,
            object: nil)
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func keyboardWillShow(notification: NSNotification) {
        guard let keyboardFrame = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.CGRectValue() else { return }
        tableViewBottomConstraint.constant = CGRectGetHeight(keyboardFrame)
        UIView.animateWithDuration(0.3) {
            self.view.updateConstraints()
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        tableViewBottomConstraint.constant = 0.0
        UIView.animateWithDuration(0.3) {
            self.view.updateConstraints()
        }
    }
    
    func tableTapped(recognizer: UITapGestureRecognizer) {
        let location = recognizer.locationInView(tableView)
        let path = tableView.indexPathForRowAtPoint(location)
        if searchBar.isFirstResponder() {
            searchBar.resignFirstResponder()
        } else if let path = path {
            tableView.selectRowAtIndexPath(path, animated: true, scrollPosition: .Middle)
        }
    }
}
