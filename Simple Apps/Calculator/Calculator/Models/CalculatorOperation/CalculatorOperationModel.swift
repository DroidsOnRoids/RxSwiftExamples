//
//  CalculatorOperation.swift
//  Calculator
//
//  Created by Lukasz Mroz on 01.03.2016.
//  Copyright © 2016 Droids on Roids. All rights reserved.
//

enum CalculatorOperationModel {
    
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

extension String {
    
    func toOperation() -> CalculatorOperationModel {
        switch self {
        case "+":
            return .Add
        case "-":
            return .Substract
        case "C":
            return .Clear
        case ".":
            return .Dot
        case "=":
            return .Equal
        case "%":
            return .Percent
        default:
            if let number = Int(self) where 0...9 ~= number {
                return .Number(number)
            }
            
            return .None
        }
    }
    
}