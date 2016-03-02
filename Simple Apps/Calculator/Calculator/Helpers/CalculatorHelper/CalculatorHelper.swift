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
    
}