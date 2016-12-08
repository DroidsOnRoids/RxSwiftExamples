//
//  ViewController.swift
//  ColourfulBall
//
//  Created by Lukasz Mroz on 19.03.2016.
//  Copyright © 2016 Droids On Roids. All rights reserved.
//
//  This example is to show how you can use MVVM (Model-View-ViewModel)
//  with Rx and Swift. Since we don't need any of the properties that RxViewModel
//  gives, we won't use it in this project. However, if you want more advanced
//  usage, I really encourage you to visit RxSwiftCommunity/RxViewModel on github.
//
//  In this project we need one ViewModel, which will have logic to our CircleView.
//  More on the functionality of the Model in CircleViewModel.swift. Here we observe
//  when the color of circle should be changed (by subscribing to the observable
//  in CircleViewModel, and based on the color given, we change the color of the
//  CircleView and use the complementary color for the background view given by
//  Chameleon. To achieve that we need to bind the center of the CircleView frame
//  to centerObservable in CircleViewModel. It will then handle the rest.

import ChameleonFramework
import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    var circleView: UIView!
    private var circleViewModel: CircleViewModel!
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
        circleView.backgroundColor = UIColor.green
        view.addSubview(circleView)
        
        circleViewModel = CircleViewModel()
        // Bind the center point of the CircleView to the centerObservable
        circleView.rx.observe(CGPoint.self, "center")
        .bindTo(circleViewModel.centerVariable)
        .addDisposableTo(disposeBag)
        // Subscribe to backgroundObservable to get new colors from the ViewModel.
        
        
        circleViewModel.backgroundColorObservale
            .subscribe(onNext: { [weak self] (backgroundColor) in
                UIView.animate(withDuration: 0.1) {
                    self?.circleView.backgroundColor = backgroundColor
                    // Try to get complementary color for given background color
                    let viewBackgroundColor = UIColor.init(complementaryFlatColorOf: backgroundColor)
                    // If it is different that the color
                    if viewBackgroundColor != backgroundColor {
                        // Assign it as a background color of the view
                        // We only want different color to be able to see that circle in a view
                        self?.view.backgroundColor = viewBackgroundColor
                    }
                }
            }).addDisposableTo(disposeBag)
        
        
        let gestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(circleMoved(_:)))
        circleView.addGestureRecognizer(gestureRecognizer)
    }
    
    func circleMoved(_ recognizer: UIPanGestureRecognizer) {
        let location = recognizer.location(in: view)
        UIView.animate(withDuration: 0.1) {
            self.circleView.center = location
        }
    }
    
}


