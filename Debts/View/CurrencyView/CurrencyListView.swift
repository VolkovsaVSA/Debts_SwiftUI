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
    @EnvironmentObject private var adsVM: AdsViewModel
    
    @State private var searchText = ""
    
    private var calcPadding: CGFloat {
        if UIDevice.current.userInterfaceIdiom == .pad {
            return UIScreen.main.bounds.width / 3
        } else {
            return 24
        }
    }
    
    var body: some View {
        
        GeometryReader { geometry in
            List {
                if !UserDefaults.standard.bool(forKey: IAPProducts.fullVersion.rawValue) {
                    AdsManager.BannerVC(size: CGSize(width: geometry.size.width - 24 , height: 50)).offset(x: -16, y: -6)
                }
                Section(header: Text(LocalStrings.Views.CurrencyView.favorites)) {
                    ForEach(currencyListVM.favoritesCurrency, id:\.self) { item in
                        currencyButton(item)

                    }
                }
                Section(header: Text(LocalStrings.Views.CurrencyView.allCurrency)) {
                    ForEach(searchResults, id:\.self) { item in
                        currencyButton(item)
                    }
                    .searchable(text: $searchText, prompt: LocalStrings.Views.CurrencyView.currencyName)
                }
                
            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle(LocalStrings.NavBar.currency)
            .navigationBarTitleDisplayMode(.large)
            .onDisappear() {
                addDebtVM.selectCurrencyPush = false
            }
            .ignoresSafeArea(.keyboard, edges: .all)
        }
        
//        List {
//            if !UserDefaults.standard.bool(forKey: IAPProducts.fullVersion.rawValue) {
//                AdsManager.BannerVC(size: CGSize(width: UIScreen.main.bounds.width - calcPadding, height: 44)).offset(x: -16, y: -6)
//            }
//            Section(header: Text(LocalStrings.Views.CurrencyView.favorites)) {
//                ForEach(currencyListVM.favoritesCurrency, id:\.self) { item in
//                    currencyButton(item)
//
//                }
//            }
//            Section(header: Text(LocalStrings.Views.CurrencyView.allCurrency)) {
//                ForEach(searchResults, id:\.self) { item in
//                    currencyButton(item)
//                }
//                .searchable(text: $searchText, prompt: LocalStrings.Views.CurrencyView.currencyName)
//            }
//
//        }
//        .listStyle(InsetGroupedListStyle())
//        .navigationTitle(LocalStrings.NavBar.currency)
//        .navigationBarTitleDisplayMode(.large)
//        .onDisappear() {
//            addDebtVM.selectCurrencyPush = false
//        }
//        .ignoresSafeArea(.keyboard, edges: .all)
        
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
    
    private var searchResults: [CurrencyModel] {
        if searchText.isEmpty {
            return currencyListVM.allCurrency
        } else {
            return currencyListVM.allCurrency.filter { $0.localazedString.lowercased().contains(searchText.lowercased()) }
        }
    }
    
    
}

