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
            .rx_willStartLoadingMap
            .subscribeNext {
                print("Will start loading map")
            }
            .addDisposableTo(disposeBag)
        mapView
            .rx_didFinishLoadingMap
            .subscribeNext {
                print("Finished loading map")
            }
            .addDisposableTo(disposeBag)
        mapView
            .rx_willStartRenderingMap
            .subscribeNext {
                print("Will start rendering map")
            }
            .addDisposableTo(disposeBag)
        mapView
            .rx_didFinishRenderingMap
            .subscribeNext { fullyRendered in
                print("Finished rendering map? Is it fully rendered tho? Of course \(fullyRendered)!")
            }
            .addDisposableTo(disposeBag)
    }
    
}

