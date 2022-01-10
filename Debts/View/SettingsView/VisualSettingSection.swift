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
    
    @State private var navTitle = LocalStrings.NavBar.settings
    
    
    var body: some View {
        Section(header: Text(LocalStrings.Views.Settings.visualSettings).fontWeight(.semibold).foregroundColor(.primary)) {
            HStack(alignment: .center, spacing: 6) {
                Image(systemName: "paintbrush")
                    .frame(width: 28, height: 28)
                    .foregroundColor(.white)
                    .background(
                        RoundedRectangle(cornerRadius: 6, style: .circular)
                            .fill(Color.indigo)
                    )
                Picker(LocalStrings.Views.Settings.theme, selection: $settingsVM.preferedColorscheme) {
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
                Picker(LocalStrings.Views.Settings.displayingNames, selection: $settingsVM.displayingNamesSelection) {
                    ForEach(DisplayingNamesModel.allCases, id: \.self) {item in
                        Text(DisplayingNamesModel.localize(inputCase: item))
                    }
                }
                .lineLimit(nil)
                .multilineTextAlignment(.leading)
            }
            .listRowSeparator(.hidden)

            SettingsToggleCell(title: LocalStrings.Views.Settings.showCurrencyCode,
                             systemImage: "coloncurrencysign.circle",
                               isOn: $currencyVM.showCurrencyCode,
                               backgroundColor: .green)
            SettingsToggleCell(title: LocalStrings.Views.Settings.includeInterestAndPenalties,
                             systemImage: "dollarsign.circle",
                               isOn: $settingsVM.totalAmountWithInterest,
                               backgroundColor: .gray)

        }
        
    }
}

