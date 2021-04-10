//
//  Currency.swift
//  Debts
//
//  Created by Sergey Volkov on 29.09.2020.
//  Copyright © 2020 Sergey Volkov. All rights reserved.
//

import Foundation


struct Currency {
    struct CurrentLocal {
        static var currencyCode: String {
            let formatter = NumberFormatter()
            formatter.locale = Locale.current
            return formatter.locale.currencyCode ?? "USD"
        }
        static var currencySymbol: String {
            let formatter = NumberFormatter()
            formatter.locale = Locale.current
            return formatter.locale.currencySymbol ?? "$"
        }
        static var selectedCurrency = LocID(currencyCode: Currency.CurrentLocal.currencyCode, currencySymbol: Currency.CurrentLocal.currencySymbol, localazedString: localazedStringForCode(currencyCode: Currency.CurrentLocal.currencyCode))
    }
    struct AllCurrency {
        static var favoritescurrency = [
            Currency.CurrentLocal.selectedCurrency
        ]
        static var arrayAllcurrency: [LocID] {
            var locIDarray = [LocID]()
            let formatter = NumberFormatter()
            for identifire in Locale.availableIdentifiers {
                formatter.locale = Locale(identifier: identifire)
                
                let local = Locale(identifier: identifire)
                
                if let currencyCode = local.currencyCode, local.currencyCode != local.currencySymbol {
                    var currency = LocID(currencyCode: currencyCode, currencySymbol: local.currencySymbol ?? currencyCode, localazedString: "")
                    
                    if !locIDarray.contains(currency) {
                        formatter.locale = Locale.current
                        currency.localazedString = formatter.locale.localizedString(forCurrencyCode: currency.currencyCode) ?? "n/a"
                        locIDarray.append(currency)
                    }
                    
                }
            }
            locIDarray = locIDarray.sorted(by: {$0.currencyCode < $1.currencyCode})
            return locIDarray
        }
        static var usedArrayAllCurrency = [LocID]()
    }

}


fileprivate func localazedStringForCode(currencyCode: String) -> String {
    let formatter = NumberFormatter()
    formatter.locale = Locale.current
    return formatter.locale.localizedString(forCurrencyCode: currencyCode) ?? "n/a"
}
fileprivate func filteredArrayAllcurrency(code: String) -> [LocID] {
    return (Currency.AllCurrency.usedArrayAllCurrency.filter {$0.currencyCode == code})
}


