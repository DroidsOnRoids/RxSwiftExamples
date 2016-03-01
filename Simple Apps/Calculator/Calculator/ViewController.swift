//
//  ViewController.swift
//  Calculator
//
//  Created by Lukasz Mroz on 26.02.2016.
//  Copyright © 2016 Droids on Roids. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: CalculatorCollectionView!
    @IBOutlet weak var resultLabel: UILabel!
    
    var collectionViewModel: CalculatorCollectionViewModel!
    var resultsViewModel: CalculatorResultsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        collectionViewModel = CalculatorCollectionViewModel()
        resultsViewModel = CalculatorResultsViewModel()
    }

}

