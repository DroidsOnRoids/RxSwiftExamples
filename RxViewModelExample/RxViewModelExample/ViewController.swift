//
//  ViewController.swift
//  RxViewModelExample
//
//  Created by Lukasz Mroz on 09.02.2016.
//  Copyright © 2016 Droids on Roids. All rights reserved.
//
//
//  This example is to show how you can use MVVM (Model-View-ViewModel)
//  with Rx and Swift. We will use RxViewModel to be sure our view is active.
//  Here we need one ViewModel, which will have logic to our CircleView. More
//  on the functionality of the Model in CircleViewModel.swift. Here we observer
//  when the color of circle should be changed (by subscribing to the observable
//  in CircleViewModel, and based on the color given, we change the color of the 
//  CircleView and use the complementary color for the background view given by
//  Chameleon. To achieve that we need to bind the center of the CircleView frame
//  to centerObservable in CircleViewModel. It will then handle the rest.
//
//

import ChameleonFramework
import UIKit
import RxSwift
import RxCocoa
import RxViewModel

class ViewController: UIViewController {

    var circleView: UIView!
    private var circleViewModel: CircleViewModel?
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    func setup() {
        // Add circle view
        circleView = UIView(frame: CGRect(origin: view.center, size: CGSize(width: 100.0, height: 100.0)))
        circleView.layer.cornerRadius = circleView.frame.width / 2.0
        circleView.center = view.center
        circleView.backgroundColor = UIColor.greenColor()
        view.addSubview(circleView)
        
        circleViewModel = CircleViewModel()
        // Bind the center point of the CircleView to the centerObservable
        _ = circleView
            .rx_observe(CGPoint.self, "center")
            .bindTo(circleViewModel!.centerObservable)
        
        // Subscribe to backgroundObservable to get new colors from the ViewModel.
        circleViewModel?.backgroundColorObservable
            .subscribeNext({ (backgroundColor) in
                UIView.animateWithDuration(0.1) {
                    self.circleView.backgroundColor = backgroundColor
                    self.view.backgroundColor = UIColor.init(complementaryFlatColorOf: backgroundColor, withAlpha: 1.0)
                }
            })
            .addDisposableTo(disposeBag)
        
        let gestureRecognizer = UIPanGestureRecognizer(target: self, action: "circleMoved:")
        circleView.addGestureRecognizer(gestureRecognizer)
    }
    
    func circleMoved(recognizer: UIPanGestureRecognizer) {
        let location = recognizer.locationInView(view)
        UIView.animateWithDuration(0.1) {
            self.circleView.center = location
        }
    }
    
}

