//
//  PrivacySection.swift
//  Debts
//
//  Created by Sergei Volkov on 13.12.2021.
//

import SwiftUI

struct PrivacySection: View {
    @EnvironmentObject private var currencyVM: CurrencyViewModel
    @EnvironmentObject private var settingsVM: SettingsViewModel
    
    var body: some View {
        Section(header: Text("Privacy").fontWeight(.semibold).foregroundColor(.primary)) {
            Toggle("Use authentication", isOn: $settingsVM.authentication)
                .listRowSeparator(.hidden)
        }
    }
}

