//
//  SettingsView.swift
//  Debts
//
//  Created by Sergei Volkov on 14.04.2021.
//

import SwiftUI

struct SettingsView: View {
    
    @EnvironmentObject var currencyVM: CurrencyViewModel
    
    
    var body: some View {
        
        NavigationView {
            Form {
                Toggle("Show currency code", isOn: $currencyVM.showCurrencyCode)
            }
                .navigationTitle(LocalizedStringKey("Settings"))
        }
        
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
