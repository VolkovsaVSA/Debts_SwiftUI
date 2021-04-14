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
    var debtorStatus: DebtorStatus
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



var Debtors = [
    Debtor(fristName: "Alex",
           familyName: "BarBarBarBarBar",
           phone: nil,
           email: nil,
           debtorStatus: DebtorStatus.debtor,
           debts: []),
    Debtor(fristName: "Ivan",
           familyName: "Lun",
           phone: nil,
           email: nil,
           debtorStatus: DebtorStatus.creditor,
           debts: []),
    Debtor(fristName: "Miha",
           familyName: "Dub",
           phone: nil,
           email: nil,
           debtorStatus: DebtorStatus.creditor,
           debts: [])
]

var Debts = [
    Debt(initialDebt: 100,
         balanceOfDebt: 100,
         startDate: Date(timeIntervalSince1970: 1037563872),
         endDate: Date(timeIntervalSince1970: 1047563872),
         isClosed: false,
         percentType: nil,
         percentAmount: nil,
         payments: [],
         debtor: Debtors[0], currencyCode: "USD"),
    Debt(initialDebt: 200,
         balanceOfDebt: 200,
         startDate: Date(timeIntervalSince1970: 1137563872),
         endDate: Date(timeIntervalSince1970: 1147563872),
         isClosed: false,
         percentType: nil,
         percentAmount: nil,
         payments: [],
         debtor: Debtors[1], currencyCode: "USD"),
    Debt(initialDebt: 10,
         balanceOfDebt: 10,
         startDate: Date(timeIntervalSince1970: 2007563872),
         endDate: Date(timeIntervalSince1970: 22007563872),
         isClosed: false,
         percentType: nil,
         percentAmount: nil,
         payments: [],
         debtor: Debtors[2], currencyCode: "USD"),
]
