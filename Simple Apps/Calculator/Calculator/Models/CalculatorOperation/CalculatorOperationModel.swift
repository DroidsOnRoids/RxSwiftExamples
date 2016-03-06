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
    
    func merge(operation: CalculatorOperationModel) -> [CalculatorOperationModel] {
        // It could be less code for this part
        // But I've found out that it was less readable
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
    
    func compute(number1: CalculatorOperationModel, operation: CalculatorOperationModel, number2: CalculatorOperationModel) -> CalculatorOperationModel {
        guard case .Number(let digit1) = number1, .Number(let digit2) = number2 else {
            return .None
        }
        
        switch operation {
        case .Add:
            return .Number(digit1 + digit2)
        case .Substract:
            return .Number(digit1 - digit2)
        case .Percent:
            return .Number(digit1 % digit2)
        default:
            return .None
        }
        
    }
}

extension String {
    
    func toOperation() -> CalculatorOperationModel {
        return CalculatorHelper.readableStringToOperation(self)
    }
    
}