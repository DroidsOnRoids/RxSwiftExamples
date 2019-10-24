//
//  ViewController.swift
//  RxMKMapViewExample
//
//  Created by Lukasz Mroz on 18.02.2016.
//  Copyright © 2016 Droids on Roids. All rights reserved.
//

import MapKit
import RxSwift
import RxCocoa
import RxMKMapView
import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRx()
    }
    
    func setupRx() {
        mapView
            .rx.willStartLoadingMap
            .subscribe(onNext: {
                print("Will start loading map")
            })
            .disposed(by: disposeBag)
        mapView
            .rx.didFinishLoadingMap
            .subscribe(onNext: {
                print("Finished loading map")
            })
            .disposed(by: disposeBag)
        mapView
            .rx.willStartRenderingMap
            .subscribe(onNext: {
                print("Will start rendering map")
            })
            .disposed(by: disposeBag)
        mapView
            .rx.didFinishRenderingMap
            .subscribe(onNext: { fullyRendered in
                print("Finished rendering map? Is it fully rendered tho? Of course \(fullyRendered)!")
            })
            .disposed(by: disposeBag)
    }
}

