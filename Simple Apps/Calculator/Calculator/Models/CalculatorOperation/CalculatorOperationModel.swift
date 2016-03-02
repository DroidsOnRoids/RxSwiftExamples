//
//  CalculatorOperation.swift
//  Calculator
//
//  Created by Lukasz Mroz on 01.03.2016.
//  Copyright © 2016 Droids on Roids. All rights reserved.
//

public enum CalculatorOperationModel: Equatable {
    
    case None
    case Add
    case Clear
    case Dot
    case Equal
    case CurrencyExchange(Currency, Currency)
    case Number(Int)
    case Percent
    case Substract
    
}

public func ==(lhs: CalculatorOperationModel, rhs: CalculatorOperationModel) -> Bool {
    return String(stringInterpolationSegment: lhs) == String(stringInterpolationSegment: rhs)
}

extension CalculatorOperationModel {
    
    func toReadableString() -> String {
        return CalculatorHelper.operationToReadableString(self)
    }
    
    // TODO: Implement merging operations
    // It should have check for 2 numbers (merge), 2 operators(replace)
    // also 2 different operations
    func merge(operation: CalculatorOperationModel) -> [CalculatorOperationModel] {
        return []
    }
    
}

extension String {
    
    func toOperation() -> CalculatorOperationModel {
        return CalculatorHelper.readableStringToOperation(self)
    }
    
}