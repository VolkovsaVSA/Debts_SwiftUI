//
//  DebtsViewModel.swift
//  Debts
//
//  Created by Sergei Volkov on 13.04.2021.
//

import Foundation

class DebtorsDebtsViewModel: ObservableObject {
    @Published var debtors = Debtors
    @Published var debts = Debts
    
    func getAllAmountOfDebtsOneDebtor(debtor: Debtor)->Decimal {
        let allDebts = debts.filter { $0.debtor == debtor }
        var amount: Decimal = 0
        allDebts.forEach { debt in
            amount += debt.totalDebt
        }
        return amount
    }
}
