//
//  CurrencyListViewModel.swift
//  Debts
//
//  Created by Sergei Volkov on 11.04.2021.
//

import Foundation
import WidgetKit

final class CurrencyViewModel: ObservableObject {
    
    static let shared = CurrencyViewModel()
    
    @Published var favoritesCurrency = Currency.AllCurrency.favoritescurrency
    @Published var allCurrency = Currency.AllCurrency.allcurrencys
    @Published var selectedCurrency = Currency.CurrentLocal.localCurrency
    @Published var showCurrencyCode = false {
        didSet {
            AppGroup.MyDefaults.save(value: showCurrencyCode, key: AppGroup.MyDefaults.showCurrencySegmentKey)
            WidgetCenter.shared.reloadAllTimelines()
        }
    }
    
    init() {
        showCurrencyCode = AppGroup.MyDefaults.load(key: AppGroup.MyDefaults.showCurrencySegmentKey) as? Bool ?? false
    }
    
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
        return Currency.currencyFormatter(currency: amount,
                                          currencyCode: currencyCode,
                                          showCode: showCurrencyCode)
    }
    func debtBalanceFormat(debt: DebtCD) -> String {
        
        var balance = ""
        if SettingsViewModel.shared.totalAmountWithInterest {
            balance = Currency.currencyFormatter(
                currency: debt.debtBalance +
                debt.interestBalance(defaultLastDate: Date()) + debt.penaltyBalance(toDate: Date())
                ,
                currencyCode: debt.currencyCode,
                showCode: showCurrencyCode)
        } else {
            balance = Currency.currencyFormatter(currency: debt.debtBalance,
                                                 currencyCode: debt.currencyCode,
                                                 showCode: showCurrencyCode)
        }

        if debt.debtorStatus == DebtorStatus.debtor.rawValue {
            return "+" + balance
        } else {
            return "-" + balance
        }
        
    }
}
