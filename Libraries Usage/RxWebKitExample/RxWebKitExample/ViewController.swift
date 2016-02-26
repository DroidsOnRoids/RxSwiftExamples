//
//  ViewController.swift
//  RxWebKitExample
//
//  Created by Lukasz Mroz on 16.02.2016.
//  Copyright © 2016 Droids on Roids. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import RxWebKit
import WebKit

class ViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var webViewWrapper: UIView!
    
    var webView: WKWebView!
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupRx()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupResizing()
    }

    func setupUI() {
        webView = WKWebView(frame: webViewWrapper.frame)
        webViewWrapper.addSubview(webView)
        searchBar.text = "https://github.com/ReactiveX/RxSwift"
    }
    
    func setupResizing() {
        webView.frame = webViewWrapper.frame
        webView.frame.origin = CGPointZero
    }
    
    func setupRx() {
        webView
            .rx_title
            .filter { $0?.characters.count > 0 }
            .subscribeNext { title in
                self.title = title
            }
            .addDisposableTo(disposeBag)
        
        searchBar
            .rx_text
            .throttle(0.5, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .filter { NSURL(string: $0) != nil }
            .map { NSURL(string: $0)! }
            .subscribeNext({ url in
                self.webView.loadRequest(NSURLRequest(URL: url))
            })
            .addDisposableTo(disposeBag)
        
        webView.rx_URL
            .subscribeNext { url in
                self.searchBar.text = url?.absoluteString
                print("URL: \(url)")                
            }
            .addDisposableTo(disposeBag)
        
        webView.rx_estimatedProgress
            .subscribeNext {
                print("estimatedProgress: \($0)")
            }
            .addDisposableTo(disposeBag)
        
        webView.rx_loading
            .subscribeNext { loading in
                UIApplication.sharedApplication().networkActivityIndicatorVisible = loading
                print("loading: \(loading)")
            }
            .addDisposableTo(disposeBag)
    }
    
}

