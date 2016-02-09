//
//  CircleViewModel.swift
//  RxViewModelExample
//
//  Created by Lukasz Mroz on 09.02.2016.
//  Copyright © 2016 Droids on Roids. All rights reserved.
//

import ChameleonFramework
import Foundation
import RxSwift
import RxCocoa
import RxViewModel

class CircleViewModel: RxViewModel {
    
    var centerObservable = Variable<CGPoint?>(CGPointZero) // Create one variable that will be changed and observed
    var backgroundColorObservable: Observable<UIColor> // Create observable that we will be changing based on center
    private let disposeBag = DisposeBag()
    
    override init() {
        backgroundColorObservable = Observable.never() // Just to init the variable and remove warning from Xcode
        super.init()
        
        // When view is active & we get new center, map it to UIColor
        backgroundColorObservable = Observable.of(didBecomeActive.map { _ in CGPoint() }, centerObservable.asObservable())
            .merge()
            .map { frame in
                guard let frame = frame else { return UIColor.blackColor() }
                
                let red: CGFloat = ((frame.x + frame.y) % 255.0) / 255.0
                let green: CGFloat = 0.0
                let blue: CGFloat = 0.0

                return UIColor.flatten(UIColor(red: red, green: green, blue: blue, alpha: 1.0))()
            }
    }
    
}