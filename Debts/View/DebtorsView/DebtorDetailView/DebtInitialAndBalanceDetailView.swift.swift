//
//  DebtInitialAndBalanceDetailView.swift.swift
//  Debts
//
//  Created by Sergei Volkov on 05.12.2021.
//

import SwiftUI

struct DebtInitialAndBalanceDetailView: View {
    
    @EnvironmentObject private var currencyVM: CurrencyViewModel
    @ObservedObject var debt: DebtCD
    
    var body: some View {

        HStack {
            Text(LocalStrings.Debt.PenaltyType.DynamicType.PercentChargeType.initialDebt)
                .fontWeight(.thin)
            Spacer()
            Text(debt.debtPrefix + currencyVM.currencyConvert(amount: debt.initialDebt as Decimal, currencyCode: debt.currencyCode))
                .foregroundColor(DebtorStatus(rawValue: debt.debtorStatus) == DebtorStatus.debtor ? Color.green : Color.red)
                .fontWeight(.bold)

        }
        HStack {
            Text(LocalStrings.Debt.PenaltyType.DynamicType.PercentChargeType.balance)
                .fontWeight(.thin)
            Spacer()
            Text(currencyVM.debtBalanceFormat(debt: debt))
                .foregroundColor(DebtorStatus(rawValue: debt.debtorStatus) == DebtorStatus.debtor ? Color.green : Color.red)
                .fontWeight(.bold)
        }
        
    }
}

