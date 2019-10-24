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
        return searchBar.rx.text
            .filter { $0 != nil }
            .map { $0! }
            .filter { $0.count > 0 }
            .debounce(.milliseconds(500), scheduler: MainScheduler.instance)
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
            .drive(tableView.rx.items) { (tv, i, repository) in
                let cell = tv.dequeueReusableCell(withIdentifier: "repositoryCell", for: IndexPath(row: i, section: 0))
                cell.textLabel?.text = repository.name
                
                return cell
            }
            .disposed(by: disposeBag)
        
        repositoryNetworkModel
            .rx_repositories
            .drive(onNext: { repositories in
                if repositories.count == 0 {
                    let alert = UIAlertController(title: ":(", message: "No repositories for this user.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    if self.navigationController?.visibleViewController is UIAlertController != true {
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            })
            .disposed(by: disposeBag)
    }
    
    func setupUI() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(tableTapped(_:)))
        tableView.addGestureRecognizer(tap)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow(_:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide(_:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        guard let keyboardFrame = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        tableViewBottomConstraint.constant = keyboardFrame.height
        UIView.animate(withDuration: 0.3, animations: {
            self.view.updateConstraints()
        }) 
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        tableViewBottomConstraint.constant = 0.0
        UIView.animate(withDuration: 0.3, animations: {
            self.view.updateConstraints()
        })
    }
    
    @objc func tableTapped(_ recognizer: UITapGestureRecognizer) {
        let location = recognizer.location(in: tableView)
        let path = tableView.indexPathForRow(at: location)
        if searchBar.isFirstResponder {
            searchBar.resignFirstResponder()
        } else if let path = path {
            tableView.selectRow(at: path, animated: true, scrollPosition: .middle)
        }
    }
}
