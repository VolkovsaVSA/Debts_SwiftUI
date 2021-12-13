//
//  VisualSettingSection.swift
//  Debts
//
//  Created by Sergei Volkov on 13.12.2021.
//

import SwiftUI

struct VisualSettingSection: View {
    @EnvironmentObject private var currencyVM: CurrencyViewModel
    @EnvironmentObject private var settingsVM: SettingsViewModel
    
    var body: some View {
        Section(header: Text("Visual settings").fontWeight(.semibold).foregroundColor(.primary)) {
            VStack {
                Toggle("Show currency code", isOn: $currencyVM.showCurrencyCode)
                    .listRowSeparator(.hidden)
                Toggle("Show additional info", isOn: $settingsVM.showAdditionalInfo)
                    .listRowSeparator(.hidden)
                Toggle("The total amount of debt with accrued interest and penalties", isOn: $settingsVM.totalAmountWithInterest)
            }
        }
    }
}

