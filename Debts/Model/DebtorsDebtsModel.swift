//
//  DebtorsDebtsModel.swift
//  Debts
//
//  Created by Sergei Volkov on 04.05.2021.
//

import Foundation

struct DebtorsDebtsModel: Hashable, Identifiable {
    let currencyCode: String
    var amount: Decimal
    
    var id: Int {
        hashValue
    }
}
