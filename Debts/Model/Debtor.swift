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
    var interestType: PercentType?
    var interest: Decimal?
    var interestAmount: Decimal?
    var payments: [Payment]
    var debtor: Debtor
    var currencyCode: String
    
    var totalDebt: Decimal {
        return balanceOfDebt + (interestAmount ?? 0)
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



let debtors = [
    Debtor(fristName: "Alex",
           familyName: "BarBarBarBarBar",
           phone: nil,
           email: nil,
           isDebtor: true,
           debts: []),
    Debtor(fristName: "Ivan",
           familyName: "Lun",
           phone: nil,
           email: nil,
           isDebtor: false,
           debts: []),
    Debtor(fristName: "Sasha",
           familyName: "Bal",
           phone: nil,
           email: nil,
           isDebtor: true,
           debts: []),
    Debtor(fristName: "Miha",
           familyName: "Dub",
           phone: nil,
           email: nil,
           isDebtor: false,
           debts: [])
]

let dbt = [
    Debt(initialDebt: 100,
         balanceOfDebt: 100,
         startDate: Date(timeIntervalSince1970: 1037563872),
         endDate: Date(timeIntervalSince1970: 1047563872),
         isClosed: false,
         interestType: nil,
         interestAmount: nil,
         payments: [],
         debtor: debtors[0], currencyCode: "USD"),
    Debt(initialDebt: 150150150,
         balanceOfDebt: 150150,
         startDate: Date(timeIntervalSince1970: 1337563872),
         endDate: Date(timeIntervalSince1970: 1547563872),
         isClosed: false,
         interestType: nil,
         interestAmount: nil,
         payments: [],
         debtor: debtors[0], currencyCode: "USD"),
    Debt(initialDebt: 200,
         balanceOfDebt: 200,
         startDate: Date(timeIntervalSince1970: 1137563872),
         endDate: Date(timeIntervalSince1970: 1147563872),
         isClosed: false,
         interestType: nil,
         interestAmount: nil,
         payments: [],
         debtor: debtors[1], currencyCode: "USD"),
    Debt(initialDebt: 1000,
         balanceOfDebt: 1000,
         startDate: Date(timeIntervalSince1970: 2107563872),
         endDate: Date(timeIntervalSince1970: 2117563872),
         isClosed: false,
         interestType: .perYear,
         interest: 12,
         interestAmount: 0,
         payments: [],
         debtor: debtors[2], currencyCode: "USD"),
    Debt(initialDebt: 10,
         balanceOfDebt: 10,
         startDate: Date(timeIntervalSince1970: 2007563872),
         endDate: Date(timeIntervalSince1970: 22007563872),
         isClosed: false,
         interestType: nil,
         interestAmount: nil,
         payments: [],
         debtor: debtors[3], currencyCode: "USD"),
]
