//
//  Debtor.swift
//  Debts
//
//  Created by Sergei Volkov on 07.04.2021.
//

import Foundation

struct Debtor: Identifiable, Hashable {
    let id = UUID()
    var fristName: String
    var familyName: String?
    var phone: String?
    var email: String?
    var isDebtor: Bool
    var debts: [Debt]
}

struct Debt: Identifiable, Hashable {
    static func == (lhs: Debt, rhs: Debt) -> Bool {
        return lhs.id == rhs.id
    }
    
    let id = UUID()
    var initialDebt: Decimal
    var balanceOfDebt: Decimal
    var startDate: Date?
    var endDate: Date?
    var isClosed: Bool
    var percentType: PercentType?
    var percentAmount: Decimal?
    var payments: [Payment]
    var debtor: Debtor
}

struct Payment: Hashable {
    let id = UUID()
    var date: Date
    var amount: Decimal
    var type: PaymentType
}

enum PaymentType: Int {
    case annuity, differentiated, custom
}
