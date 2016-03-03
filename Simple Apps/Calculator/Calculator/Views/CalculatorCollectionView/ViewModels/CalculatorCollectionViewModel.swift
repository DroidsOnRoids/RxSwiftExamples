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
    var readableOperations: Variable<String>
    let disposeBag = DisposeBag()
    
    init() {
        self.operations = Variable<[CalculatorOperationModel]>([])
        self.readableOperations = Variable<String>("0")
        setup()
    }
    
    func setup() {
        operations
            .asObservable()
            .scan([CalculatorOperationModel]()) { acumulator, values in
                var newAcumulator = acumulator
                values.forEach { newAcumulator.append($0) }
                return newAcumulator
            }
            .map { operations in
                // to readable and 
                return ""
            }
            .bindTo(readableOperations)
            .addDisposableTo(disposeBag)
    }
    
}