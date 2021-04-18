//
//  Debtor.swift
//  Debts
//
//  Created by Sergei Volkov on 07.04.2021.
//

import Foundation

struct Payment: Identifiable, Hashable {
    let id = UUID()
    var date: Date
    var amount: Decimal
    var type: PaymentType
}

enum PaymentType: Int {
    case annuity, differentiated, custom
}
