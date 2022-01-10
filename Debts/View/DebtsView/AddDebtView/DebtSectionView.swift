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
    @EnvironmentObject private var adsVM: AdsViewModel
    
    
    var body: some View {
        
        Section(header: Text(LocalStrings.Debt.Attributes.debt),
                footer: addDebtVM.editedDebt != nil ? Text("The start date cannot be earlier than the date of the first payment! \(addDebtVM.editedDebt?.allPayments.first?.date?.formatted(date: .abbreviated, time: .shortened) ?? "")") : Text(""))
        {
            
            HStack(spacing: 2) {
                TextField(LocalStrings.Views.AddDebtView.enterInitialDebt, text: $addDebtVM.debtAmount)
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
                    NavigationLink(destination: CurrencyListView(),
                                   isActive: $addDebtVM.selectCurrencyPush) {EmptyView()}
                        .onChange(of: addDebtVM.selectCurrencyPush, perform: { newValue in
                            if newValue {
                                adsVM.showInterstitial = true
                            }
                        })
                )
                    
            }
            
            TextField(LocalStrings.Debt.Attributes.comment, text: $addDebtVM.comment)

            VStack {
                DatePicker(LocalStrings.Views.DatePicker.start,
                           selection: $addDebtVM.startDate,
                           in: addDebtVM.startDateRange)
                    .onChange(of: addDebtVM.startDate) { newValue in
                        addDebtVM.calculateDateRange(debt: addDebtVM.editedDebt)
                    }
                DatePicker(LocalStrings.Views.DatePicker.end,
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
