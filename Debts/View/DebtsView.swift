//
//  DebtsView.swift
//  Debts
//
//  Created by Sergei Volkov on 07.04.2021.
//

import SwiftUI

let debtors = [
    Debtor(fristName: "Alex",
           familyName: "Bar",
           phone: nil,
           email: nil,
           isDebtor: true,
           debts: []),
    Debtor(fristName: "Ivan",
           familyName: "Lun",
           phone: nil,
           email: nil,
           isDebtor: true,
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
           isDebtor: true,
           debts: [])
]

let dbt = [
    Debt(initialDebt: 100,
         balanceOfDebt: 100,
         startDate: Date(timeIntervalSince1970: 1037563872),
         endDate: Date(timeIntervalSince1970: 1047563872),
         isClosed: false,
         percentType: nil,
         percentAmount: nil,
         payments: [],
         debtor: debtors[0]),
    Debt(initialDebt: 200,
         balanceOfDebt: 200,
         startDate: Date(timeIntervalSince1970: 1137563872),
         endDate: Date(timeIntervalSince1970: 1147563872),
         isClosed: false,
         percentType: nil,
         percentAmount: nil,
         payments: [],
         debtor: debtors[1]),
    Debt(initialDebt: 1000,
         balanceOfDebt: 1000,
         startDate: Date(timeIntervalSince1970: 2107563872),
         endDate: Date(timeIntervalSince1970: 2117563872),
         isClosed: false,
         percentType: nil,
         percentAmount: nil,
         payments: [],
         debtor: debtors[2]),
    Debt(initialDebt: 10,
         balanceOfDebt: 10,
         startDate: Date(timeIntervalSince1970: 2007563872),
         endDate: Date(timeIntervalSince1970: 22007563872),
         isClosed: false,
         percentType: nil,
         percentAmount: nil,
         payments: [],
         debtor: debtors[3]),
]

struct DebtsView: View {
    
    var body: some View {
        List(dbt, id: \.self) { item in
            VStack(alignment: .leading) {
                HStack {
                    Text(item.debtor.fristName)
                    Text(item.debtor.familyName ?? "")
                    Spacer()
                    Text(item.balanceOfDebt.description)
                }
                Text(item.startDate?.description ?? "")
            }
            
        }
    }
}

struct DebtsView_Previews: PreviewProvider {
    static var previews: some View {
        DebtsView()
    }
}
