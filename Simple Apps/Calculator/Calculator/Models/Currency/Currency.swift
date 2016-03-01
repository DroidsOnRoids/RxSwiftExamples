//
//  Currency.swift
//  Calculator
//
//  Created by Lukasz Mroz on 01.03.2016.
//  Copyright © 2016 Droids on Roids. All rights reserved.
//

enum Currency: String {
    
    case GBP
    case USD
    case PLN
    case EUR
    
}

extension Currency {
    
    func toExchangeOperation(currency: Currency) -> CalculatorOperationModel {
        return .CurrencyExchange(self, currency)
    }
    
}