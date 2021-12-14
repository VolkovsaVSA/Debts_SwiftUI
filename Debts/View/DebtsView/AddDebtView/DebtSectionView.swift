//
//  DebtSectionView.swift
//  Debts
//
//  Created by Sergei Volkov on 14.07.2021.
//

import SwiftUI

struct DebtSectionView: View {
    
    @EnvironmentObject private var addDebtVM: AddDebtViewModel
    @EnvironmentObject private var currencyVM: CurrencyViewModel
    
    
    
    var body: some View {
        
        Section(header: Text("Debt")) {
            
            HStack(spacing: 2) {
                TextField("Enter initial debt", text: $addDebtVM.debtAmount)
                    .keyboardType(.decimalPad)
                Button {
                    addDebtVM.selectCurrencyPush = true
                } label: {
                    Text(currencyVM.selectedCurrency.currencyCode)
                        .foregroundColor(AppSettings.accentColor)
                        .frame(width: 56)
                }
                .padding(.trailing, 4)
                .buttonStyle(PlainButtonStyle())
                .background(
                    NavigationLink(destination: CurrencyListView(), isActive: $addDebtVM.selectCurrencyPush) {EmptyView()}
                        
                )
                    
            }
            
            TextField("Comment", text: $addDebtVM.comment)
//                .textFieldStyle(RoundedBorderTextFieldStyle())

            VStack {
                DatePicker("Start",
                           selection: $addDebtVM.startDate,
                           in: addDebtVM.startDateRange)
                DatePicker("End",
                           selection: $addDebtVM.endDate,
                           in: addDebtVM.endDateRange)
            }
            .font(.system(size: 17, weight: .thin, design: .default))
            .accentColor(AppSettings.accentColor)
            
            
        }
        .listRowSeparator(.hidden)
        
    }
}
