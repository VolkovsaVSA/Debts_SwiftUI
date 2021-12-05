//
//  DebtInitialAndBalanceDetailView.swift.swift
//  Debts
//
//  Created by Sergei Volkov on 05.12.2021.
//

import SwiftUI

struct DebtInitialAndBalanceDetailView: View {
    
    @EnvironmentObject private var currencyVM: CurrencyViewModel
    var debt: DebtCD
    
    var body: some View {

        HStack {
            Text("Initial debt")
                .fontWeight(.thin)
            Spacer()
            Text(currencyVM.currencyConvert(amount: debt.initialDebt as Decimal, currencyCode: debt.currencyCode))
                .foregroundColor(DebtorStatus(rawValue: debt.debtorStatus) == DebtorStatus.debtor ? Color.green : Color.red)
                .fontWeight(.bold)

        }
        HStack {
            Text("Balance")
                .fontWeight(.thin)
            Spacer()
            Text(currencyVM.debtBalanceFormat(debt: debt))
                .foregroundColor(DebtorStatus(rawValue: debt.debtorStatus) == DebtorStatus.debtor ? Color.green : Color.red)
                .fontWeight(.bold)
        }
        
    }
}

