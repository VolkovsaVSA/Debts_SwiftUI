//
//  UsedCurrency.swift
//  Debts
//
//  Created by Sergey Volkov on 28.10.2019.
//  Copyright © 2019 Sergey Volkov. All rights reserved.
//

import Foundation

class UsedCurrency: Equatable {
    static func == (lhs: UsedCurrency, rhs: UsedCurrency) -> Bool {
        return (lhs.currencyCode == rhs.currencyCode) && (lhs.status == rhs.status)
    }
    var currencyCode: String
    var amount: Double
    var status: String
    
    init(currencyCode: String, amount: Double, status: String) {
        self.currencyCode = currencyCode
        self.amount = amount
        self.status = status
    }
}
