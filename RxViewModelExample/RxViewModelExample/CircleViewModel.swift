//
//  CircleViewModel.swift
//  RxViewModelExample
//
//  Created by Lukasz Mroz on 09.02.2016.
//  Copyright © 2016 Droids on Roids. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RxViewModel

class CircleViewModel: RxViewModel {
    
    var frameObservable = Variable<CGPoint?>(CGPointZero)
    var backgroundColorObservable: Observable<UIColor>

    private let disposeBag = DisposeBag()
    
    override init() {
        backgroundColorObservable = Observable.never()
        super.init()
        
        backgroundColorObservable = Observable.of(didBecomeActive.map { _ in CGPoint() }, frameObservable.asObservable())
            .merge()
            .map { frame in
                guard let frame = frame else { return UIColor.blackColor() }
                
                let red = ((frame.x + frame.y) % 255.0) / 255.0
                let green = (2*(frame.x + frame.y) % 255.0) / 255.0
                let blue = (10*(frame.x + frame.y) % 255.0) / 255.0
                
                return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
            }
    }
    
}