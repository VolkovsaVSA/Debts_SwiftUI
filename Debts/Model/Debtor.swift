//
//  Debtor.swift
//  Debts
//
//  Created by Sergei Volkov on 07.04.2021.
//

import Foundation

struct Debtor: Hashable {
//    let id = UUID()
    var fristName: String
    var familyName: String?
    var phone: String?
    var email: String?
    var debts: [Debt]
    
    var fullName: String {
        return (familyName != nil) ? (fristName + " " + familyName!) : fristName
    }
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
    var percent: Decimal?
    var percentAmount: Decimal?
    var payments: [Payment]
    var debtor: Debtor
    var currencyCode: String
    var comment: String?
    var debtorStatus: DebtorStatus
    
    var totalDebt: Decimal {
        return balanceOfDebt + (percentAmount ?? 0)
    }
}

struct Payment: Identifiable, Hashable {
    let id = UUID()
    var date: Date
    var amount: Decimal
    var type: PaymentType
}

enum PaymentType: Int {
    case annuity, differentiated, custom
}
