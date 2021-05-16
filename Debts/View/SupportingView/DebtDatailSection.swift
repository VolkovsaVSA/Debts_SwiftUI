//
//  DebtDatailSection.swift
//  Debts
//
//  Created by Sergei Volkov on 07.05.2021.
//

import SwiftUI

struct DebtDatailSection: View {
    
    @EnvironmentObject var currencyVM: CurrencyViewModel
    @ObservedObject var debt: DebtCD
    
    var body: some View {
        Section(header: Text("Debt")) {
            
            HStack(spacing: 10) {
                VStack(alignment: .leading, spacing: 10) {
                    Text("\(DebtorStatus.statusCDLocalize(status: debt.debtorStatus)):")
                    Text("Initial debt:")
                    Text("Balance:")
                    Text("Start date:")
                    Text("End date:")
                    if debt.percent != 0 {
                        Text("Percent:")
                    }
                }
                .font(.system(size: 17, weight: .thin, design: .default))
                VStack(alignment: .leading, spacing: 10) {
                    Text(debt.debtor?.fullName ?? "no debtor")
                    Text(currencyVM.currencyConvert(amount: debt.initialDebt as Decimal, currencyCode: debt.currencyCode))
                    Text(currencyVM.currencyConvert(amount: debt.fullBalance as Decimal, currencyCode: debt.currencyCode))
                    Text(debt.localizeStartDateAndTime)
                    Text(debt.localizeEndDateAndTime)
                    if debt.percent != 0 {
                        HStack {
                            Text(debt.percent.description)
                            Text("%")
                            Text(PercentType.percentTypeConvert(type: PercentType(rawValue: Int(debt.percentType)) ?? .perYear))
                            Spacer()
                        }
                    }
                }
                .font(.system(size: 17, weight: .medium, design: .default))
            }

        }
    }
}
