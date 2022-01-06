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
    
    @State private var navTitle = "Settings"
    
    
    var body: some View {
        Section(header: Text("Visual settings").fontWeight(.semibold).foregroundColor(.primary)) {
            HStack(alignment: .center, spacing: 6) {
                Image(systemName: "paintbrush")
                    .frame(width: 28, height: 28)
                    .foregroundColor(.white)
                    .background(
                        RoundedRectangle(cornerRadius: 6, style: .circular)
                            .fill(Color.indigo)
                    )
                Picker("Theme", selection: $settingsVM.preferedColorscheme) {
                    ForEach(ColorSchemeModel.allCases, id: \.self) {item in
                        Text(ColorSchemeModel.localize(inputCase: item))
                    }
                }
                .lineLimit(nil)
                .multilineTextAlignment(.leading)
            }
            .listRowSeparator(.hidden)

            
            HStack(alignment: .center, spacing: 6) {
                Image(systemName: "character")
                    .frame(width: 28, height: 28)
                    .foregroundColor(.white)
                    .background(
                        RoundedRectangle(cornerRadius: 6, style: .circular)
                            .fill(Color.blue)
                    )
                Picker("Displaying names", selection: $settingsVM.displayingNamesSelection) {
                    ForEach(DisplayingNamesModel.allCases, id: \.self) {item in
                        Text(DisplayingNamesModel.localize(inputCase: item))
                    }
                }
                .lineLimit(nil)
                .multilineTextAlignment(.leading)
            }
            .listRowSeparator(.hidden)

            SettingsToggleCell(title: LocalizedStringKey("Show currency code"),
                             systemImage: "coloncurrencysign.circle",
                               isOn: $currencyVM.showCurrencyCode,
                               backgroundColor: .green)
            SettingsToggleCell(title: LocalizedStringKey("Include interest and penalties"),
                             systemImage: "dollarsign.circle",
                               isOn: $settingsVM.totalAmountWithInterest,
                               backgroundColor: .gray)

        }
        
    }
}

