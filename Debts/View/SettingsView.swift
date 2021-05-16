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
            Form {
                Toggle("Show currency code", isOn: $currencyVM.showCurrencyCode)
                Toggle("Show additional info", isOn: $settingsVM.showAdditionalInfo)
            }
                .navigationTitle(LocalizedStringKey("Settings"))
        }
        
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(CurrencyViewModel())
            .environmentObject(SettingsViewModel())
    }
}
