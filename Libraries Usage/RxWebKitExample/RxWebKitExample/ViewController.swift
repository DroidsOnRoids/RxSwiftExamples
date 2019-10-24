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
        webView.frame.origin = CGPoint.zero
    }
    
    func setupRx() {
        webView.rx.title
            .filter { $0 != nil }
            .map { $0! }
            .filter { $0.count > 0 }
            .subscribe(onNext: { title in
                self.title = title
            })
            .disposed(by: disposeBag)
        
        searchBar.rx.text
            .filter { $0 != nil }
            .map { $0! }
            .debounce(.milliseconds(500), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .filter { URL(string: $0) != nil }
            .map { URL(string: $0)! }
            .subscribe(onNext: { url in
                self.webView.load(URLRequest(url: url))
            })
            .disposed(by: disposeBag)
        
        webView.rx.url
            .subscribe(onNext: { url in
                self.searchBar.text = url?.absoluteString
                print("URL: \(url)")                
            })
            .disposed(by: disposeBag)
        
        webView.rx.estimatedProgress
            .subscribe(onNext: {
                print("estimatedProgress: \($0)")
            })
            .disposed(by: disposeBag)
        
        webView.rx.loading
            .subscribe(onNext: { loading in
                UIApplication.shared.isNetworkActivityIndicatorVisible = loading
                print("loading: \(loading)")
            })
            .disposed(by: disposeBag)
    }   
}
