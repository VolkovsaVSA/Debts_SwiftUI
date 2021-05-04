//
//  CurrencyListViewModel.swift
//  Debts
//
//  Created by Sergei Volkov on 11.04.2021.
//

import Foundation

class CurrencyViewModel: ObservableObject {
    
    static let shared = CurrencyViewModel()
    
    @Published var favoritesCurrency = Currency.AllCurrency.favoritescurrency
    @Published var allCurrency = Currency.AllCurrency.allcurrencys
    @Published var selectedCurrency = Currency.CurrentLocal.localCurrency
    
    @Published var showCurrencyCode = false
    
    func appendToFavorites(currency: CurrencyModel) {
        if !favoritesCurrency.contains(currency) {
            favoritesCurrency.append(currency)
        }
    }
    func removeFromFavorites(currency: CurrencyModel) {
        if favoritesCurrency.contains(currency) {
            for (index, value) in favoritesCurrency.enumerated() {
                if value == currency {
                    favoritesCurrency.remove(at: index)
                }
            }
        }
    }
    
    func currencyConvert(amount: Decimal, currencyCode: String) -> String {
        return Currency.currencyFormatter(currency: amount, currencyCode: currencyCode, showCode: showCurrencyCode)
    }
    func currencyFormat(debt: DebtCD) -> String {
        
        let balance = Currency.currencyFormatter(currency: debt.fullBalance, currencyCode: debt.currencyCode, showCode: showCurrencyCode)
        
        if debt.debtorStatus == "debtor" {
            return "+" + balance
        } else {
            return "-" + balance
        }
        
    }
}
