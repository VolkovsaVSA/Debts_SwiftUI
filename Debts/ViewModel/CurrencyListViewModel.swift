//
//  CurrencyListViewModel.swift
//  Debts
//
//  Created by Sergei Volkov on 11.04.2021.
//

import Foundation

class CurrencyListViewModel: ObservableObject {
    
    static let shared = CurrencyListViewModel()
    
    @Published var favoritesCurrency = Currency.AllCurrency.favoritescurrency
    @Published var allCurrency = Currency.AllCurrency.allcurrencys
    @Published var selectedCurrency = Currency.CurrentLocal.localCurrency
    
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
}
