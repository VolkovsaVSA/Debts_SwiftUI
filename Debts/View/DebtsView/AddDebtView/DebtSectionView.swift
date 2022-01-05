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
        
        Section(header: Text("Debt"),
                footer: addDebtVM.editedDebt != nil ? Text("The start date cannot be earlier than the date of the first payment! \(addDebtVM.editedDebt?.allPayments.first?.date?.formatted(date: .abbreviated, time: .shortened) ?? "")") : Text(""))
        {
            
            HStack(spacing: 2) {
                TextField("Enter initial debt", text: $addDebtVM.debtAmount)
                    .keyboardType(.decimalPad)
                    .submitLabel(.done)
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

            VStack {
                DatePicker("Start",
                           selection: $addDebtVM.startDate,
                           in: addDebtVM.startDateRange)
                    .onChange(of: addDebtVM.startDate) { newValue in
                        addDebtVM.calculateDateRange(debt: addDebtVM.editedDebt)
                    }
                DatePicker("End",
                           selection: $addDebtVM.endDate,
                           in: addDebtVM.endDateRange)
                    .onChange(of: addDebtVM.startDate) { newValue in
                        addDebtVM.calculateDateRange(debt: addDebtVM.editedDebt)
                    }
            }
            .font(.system(size: 17, weight: .thin, design: .default))
            .accentColor(AppSettings.accentColor)
            
            
        }
        .listRowSeparator(.hidden)
        
    }
}
