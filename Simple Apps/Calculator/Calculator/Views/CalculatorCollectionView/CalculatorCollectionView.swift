//
//  CalculatorCollectionView.swift
//  Calculator
//
//  Created by Lukasz Mroz on 29.02.2016.
//  Copyright © 2016 Drods on Roids. All rights reserved.
//


import UIKit

class CalculatorCollectionView: UICollectionView {

    let calculatorCellIdentifier = "calculatorCell"
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        setup()
    }
    
    func setup() {
        delegate = self
        dataSource = self
    }
    
}

extension CalculatorCollectionView: UICollectionViewDataSource {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(calculatorCellIdentifier, forIndexPath: indexPath)
        cell.backgroundColor = UIColor.blueColor()
        
        return cell
    }
    
}

extension CalculatorCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let size = CGRectGetWidth(frame) / 3.3
        return CGSize(width: size, height: size)
    }
}