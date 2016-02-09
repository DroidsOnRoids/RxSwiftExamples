//
//  ViewController.swift
//  RxViewModelExample
//
//  Created by Lukasz Mroz on 09.02.2016.
//  Copyright © 2016 Droids on Roids. All rights reserved.
//

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
        
        // View model
        circleViewModel = CircleViewModel()
        _ = circleView
            .rx_observe(CGPoint.self, "center")
            .bindTo(circleViewModel!.frameObservable)
        
        circleViewModel?.backgroundColorObservable
            .subscribeNext({ (backgroundColor) in
                UIView.animateWithDuration(0.1) {
                    self.circleView.backgroundColor = backgroundColor
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

