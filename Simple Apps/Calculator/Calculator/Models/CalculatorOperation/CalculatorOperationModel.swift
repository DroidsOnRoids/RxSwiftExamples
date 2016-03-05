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

public enum SwitchVariant {
    case AND
    case OR
    case PASS
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
        if case .Number(let number1) = self {
            // We have min 1 number
            if case .Number(let number2) = operation {
                // Easy, 2 numbers merged to one
                return [.Number(Int("\(number1)\(number2)")!)]
            } else {
                // First one is a number, second one is a operator, return it
                return [self, operation]
            }
        } else if case .Number(_) = operation {
            // One number, one operator
            return [self, operation]
        } else {
            // We don't have numbers. Only operators. Easy
            return [operation]
        }
    }
    
}

extension CollectionType where Generator.Element == CalculatorOperationModel {
    
    func mergeOperations() -> [CalculatorOperationModel] {
        guard let count = self.count as? Int where count > 1 else { return [] }
        
    }
    
}

extension String {
    
    func toOperation() -> CalculatorOperationModel {
        return CalculatorHelper.readableStringToOperation(self)
    }
    
}