//
//  ViewController.swift
//  Calculator
//
//  Created by Lukasz Mroz on 26.02.2016.
//  Copyright © 2016 Droids on Roids. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: CalculatorCollectionView!
    @IBOutlet weak var resultLabel: UILabel!
    
    var collectionViewModel: CalculatorCollectionViewModel!
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        collectionViewModel = CalculatorCollectionViewModel()
        
        collectionView
            .rx_itemSelected
            .map { self.collectionView.values[$0.row].toOperation() }
            .subscribeNext { operation in
                print(operation)
            }
            .addDisposableTo(disposeBag)
        
    }

}

