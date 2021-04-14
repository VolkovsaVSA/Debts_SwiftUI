//
//  CurrencyView.swift
//  Debts
//
//  Created by Sergei Volkov on 10.04.2021.
//

import SwiftUI
import UIKit

struct CurrencyListView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var currencyListVM: CurrencyListViewModel
    
    var body: some View {
        
        List {
            Section(header: Text("Favorites")) {
                ForEach(currencyListVM.favoritesCurrency, id:\.self) { item in
                    currencyButton(item)
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
    }
    
    private func currencyButton(_ item: CurrencyModel) -> some View {
        return Button(action: {
            currencyListVM.selectedCurrency = item
            presentationMode.wrappedValue.dismiss()
        }, label: {
            CurrencyCell(item: item)
        })
        .buttonStyle(PlainButtonStyle())
    }
}

struct CurrencyView_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyListView()
            .environmentObject(CurrencyListViewModel())
    }
}



