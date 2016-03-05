//
//  CalculatorViewViewModel.swift
//  Calculator
//
//  Created by Lukasz Mroz on 01.03.2016.
//  Copyright © 2016 Droids on Roids. All rights reserved.
//

import RxSwift

class CalculatorCollectionViewModel {
    
    var operations: Variable<CalculatorOperationModel>
    var readableOperations: Variable<String>
    let disposeBag = DisposeBag()
    
    init() {
        self.operations = Variable<CalculatorOperationModel>(CalculatorOperationModel.None)
        self.readableOperations = Variable<String>("0")
        setup()
    }
    
    func setup() {
        operations
            .asObservable()
            .filter { $0 != .None }
            .scan([CalculatorOperationModel]()) { acumulator, value in
                var newAcumulator = acumulator
                newAcumulator.append(value)
                return newAcumulator
            }
            .map { operations in
                return CalculatorHelper.mergeToReadableString(operations)
            }
            .bindTo(readableOperations)
            .addDisposableTo(disposeBag)
    }
    
}