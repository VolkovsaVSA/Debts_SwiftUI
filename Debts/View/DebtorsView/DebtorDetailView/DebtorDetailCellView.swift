//
//  DebtDetailCellView.swift
//  Debts
//
//  Created by Sergei Volkov on 05.12.2021.
//

import SwiftUI

struct DebtorDetailCellView: View {
    
    @EnvironmentObject private var currencyVM: CurrencyViewModel
    @ObservedObject var debt: DebtCD
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Text(LocalStrings.Views.DatePicker.start)
                    .fontWeight(.light)
                Spacer()
                Text(debt.startDate?.formatted(date: .abbreviated, time: .shortened) ?? "")
            }
            HStack {
                Text(LocalStrings.Views.DatePicker.end)
                    .fontWeight(.light)
                Spacer()
                Text(debt.endDate?.formatted(date: .abbreviated, time: .shortened) ?? "")
            }
            .background(
                RoundedRectangle(cornerRadius: 4)
                    .foregroundColor((Date() > debt.endDate ?? Date()) ? .red : .clear)
            )
            
            DebtInitialAndBalanceDetailView(debt: debt)
           
        }

    }
}
