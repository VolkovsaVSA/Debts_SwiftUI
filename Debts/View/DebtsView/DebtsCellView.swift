//
//  DebtsCellView.swift
//  Debts
//
//  Created by Sergei Volkov on 14.04.2021.
//

import SwiftUI

struct DebtsCellView: View {
    
    @EnvironmentObject private var currencyVM: CurrencyViewModel
    @EnvironmentObject private var settingsVM: SettingsViewModel
    
    @State var debt: DebtCD
    
    var body: some View {
        
        HStack {
            
            PersonImage(image: debt.debtor?.image)

            VStack(alignment: .leading, spacing: 2) {
                Text(debt.debtor?.fullName ?? LocalStrings.Views.DebtsView.na)
                    .lineLimit(2)
                    .font(.system(size: 20, weight: .medium, design: .default))
                Text(currencyVM.debtBalanceFormat(debt: debt))
                    .minimumScaleFactor(0.5)
                    .font(.system(size: 20, weight: .bold, design: .default))
                    .foregroundColor(DebtorStatus(rawValue: debt.debtorStatus) == DebtorStatus.debtor ? Color.green : Color.red)
                HStack(spacing: 2) {
                    Text(debt.localizeStartDateShort).fontWeight(.light)
                    Text("-").fontWeight(.light)
                    Text(debt.localizeEndDateShort).fontWeight(.light)
                }
                .padding(.vertical, 2)
                .padding(.horizontal, 4)
                .background(
                    RoundedRectangle(cornerRadius: 4)
                        .foregroundColor((Date() > debt.endDate ?? Date()) ? .red : .clear)
                )
                .font(.caption)
            }
            Spacer()
        }
    }
}
