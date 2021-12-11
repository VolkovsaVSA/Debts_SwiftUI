//
//  CurrencyView.swift
//  Debts
//
//  Created by Sergei Volkov on 10.04.2021.
//

import SwiftUI
import UIKit

struct CurrencyListView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var currencyListVM: CurrencyViewModel
    @EnvironmentObject private var addDebtVM: AddDebtViewModel
    
    var body: some View {
        
        List {
            Section(header: Text("Favorites")) {
                ForEach(currencyListVM.favoritesCurrency, id:\.self) { item in
                    currencyButton(item)
//                        .modifier(DebtDetailCellModifire())
                }
            }
            Section(header: Text("All currency")) {
                ForEach(currencyListVM.allCurrency, id:\.self) { item in
                    currencyButton(item)
                }
            }
            
        }
        .listStyle(InsetGroupedListStyle())
        .navigationTitle(NSLocalizedString("Currency", comment: "navBarTitle"))
        .navigationBarTitleDisplayMode(.large)
        .onDisappear() {
            addDebtVM.selectCurrencyPush = false
        }
    }
    
    private func currencyButton(_ item: CurrencyModel) -> some View {
        return Button(action: {
            currencyListVM.selectedCurrency = item
            addDebtVM.isSelectedCurrencyForEditableDebr = true
            if let _ = addDebtVM.editedDebt {
                addDebtVM.editedDebt!.currencyCode = item.currencyCode
            }
            dismiss()
        }, label: {
            CurrencyCell(item: item)
        })
        .buttonStyle(PlainButtonStyle())
    }
}

