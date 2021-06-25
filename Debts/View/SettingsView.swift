//
//  SettingsView.swift
//  Debts
//
//  Created by Sergei Volkov on 14.04.2021.
//

import SwiftUI

struct SettingsView: View {
    
    @EnvironmentObject var currencyVM: CurrencyViewModel
    @EnvironmentObject var settingsVM: SettingsViewModel
    
    var body: some View {
        
        NavigationView {
            
            List {
                Toggle("Show currency code", isOn: $currencyVM.showCurrencyCode)
                    .listRowSeparator(.hidden)
                Toggle("Show additional info", isOn: $settingsVM.showAdditionalInfo)
                    .listRowSeparator(.hidden)
                Toggle("The total amount of debt with accrued interest", isOn: $settingsVM.totalAmountWithInterest)
            }
            
            .navigationTitle(LocalizedStringKey("Settings"))
        }
        
    }
}
