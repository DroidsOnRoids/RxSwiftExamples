//
//  CalculatorHelper.swift
//  Calculator
//
//  Created by Lukasz Mroz on 02.03.2016.
//  Copyright © 2016 Droids on Roids. All rights reserved.
//

public struct CalculatorHelper {
    
    internal static let readables: [String: CalculatorOperationModel] = ["+": .Add,
        "-": .Substract,
        "C": .Clear,
        ".": .Dot,
        "=": .Equal,
        "%": .Percent
    ]
    
    public static func operationToReadableString(operation: CalculatorOperationModel) -> String {
        if let string = allKeysForValue(readables, val: operation).first {
            return string
        }
        
        // If not check for number
        if case .Number(let a) = operation {
            return "\(a)"
        }
        
        // Otherwise we check for currency exchange
        if case CalculatorOperationModel.CurrencyExchange(let currency1, let currency2) = operation {
            return "\(currency1.rawValue) -> \(currency2.rawValue)"
        }
        
        return ""
    }
    
    static func readableStringToOperation(string: String) -> CalculatorOperationModel {
        if let operation = readables[string] {
            return operation
        }
        
        // If not check for number
        if let number = Int(string) where 0...9 ~= number {
            return .Number(number)
        }
        
        // Otherwise we check for currency exchange
        let currencies = string.componentsSeparatedByString(" -> ")
        if currencies.count == 2 {
            if let currency1 = Currency(rawValue: currencies.first!), let currency2 = Currency(rawValue: currencies.last!) {
                return .CurrencyExchange(currency1, currency2)
            }
        }
        
        return .None
    }
    
    static func allKeysForValue<K, V : Equatable>(dict: [K : V], val: V) -> [K] {
        return dict.filter{ $0.1 == val }.map{ $0.0 }
    }
    
    static func mergeOperations(operations: [CalculatorOperationModel]) -> [CalculatorOperationModel] {
        guard operations.count > 1 else { return [] }
        
        var returnOperations = operations
        var lastIndex = 0
        var currentIndex = 1
        var mergedOperations: [CalculatorOperationModel]!

        // merge operations
        while currentIndex < returnOperations.count {
            mergedOperations = returnOperations[lastIndex].merge(returnOperations[currentIndex])
            while mergedOperations.count == 1 {
                returnOperations.removeRange(Range<Int>(start: lastIndex, end: currentIndex+1))
                returnOperations.insert(mergedOperations.first!, atIndex: lastIndex)
                currentIndex = lastIndex + 1
                if currentIndex >= returnOperations.count {
                    break
                }
                mergedOperations = returnOperations[lastIndex].merge(returnOperations[currentIndex])
            }
            lastIndex = currentIndex
            currentIndex = lastIndex + 1
        }
        
        // Now compute result if equal sign is given
        
        return returnOperations
    }
    
    static internal func compute(operations: [CalculatorOperationModel]) -> CalculatorOperationModel {
        
        return .Number(0)
    }
    
    static func operationsToReadableString(operations: [CalculatorOperationModel]) -> String {
        return operations.map { operationToReadableString($0) }.reduce("", combine: +)
    }
    
    static func mergeToReadableString(operations: [CalculatorOperationModel]) -> String {
        return operationsToReadableString(mergeOperations(operations))
    }
    
}