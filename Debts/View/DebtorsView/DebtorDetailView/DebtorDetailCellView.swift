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
                Text("Start")
                    .fontWeight(.light)
                Spacer()
                Text(debt.startDate?.formatted(date: .abbreviated, time: .shortened) ?? "")
//                    .fontWeight(.semibold)
            }
            HStack {
                Text("End")
                    .fontWeight(.light)
                Spacer()
                Text(debt.endDate?.formatted(date: .abbreviated, time: .shortened) ?? "")
//                    .fontWeight(.semibold)
            }
            .background(
                RoundedRectangle(cornerRadius: 4)
                    .foregroundColor(debt.endDate?.daysBetweenDate(toDate: Date()) ?? -1 > 0 ? .red : .clear)
            )
            
            DebtInitialAndBalanceDetailView(debt: debt)
           
        }

    }
}
