//
//  CalculatorViewViewModel.swift
//  Calculator
//
//  Created by Lukasz Mroz on 01.03.2016.
//  Copyright © 2016 Droids on Roids. All rights reserved.
//

import RxSwift

class CalculatorCollectionViewModel {
    
    var operations: Variable<[CalculatorOperationModel]>
    var readableOperations: Variable<[String]>
    
    init() {
        self.operations = Variable<[CalculatorOperationModel]>([])
        self.readableOperations = Variable<[String]>([])
    }
    
    func operationsToReadable() {
        var readableOperations = [String]()
        
        
    }
    
}