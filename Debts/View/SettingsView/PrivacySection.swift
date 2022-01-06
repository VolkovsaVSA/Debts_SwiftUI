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
            SettingsToggleCell(title: LocalizedStringKey("Use authentication"),
                               systemImage: biometryImage(),
                               isOn: $settingsVM.authentication,
                               backgroundColor: .green /*settingsVM.authentication ? .green : .red*/)
        }
    }
    
    private func biometryImage() -> String {
        switch settingsVM.biometry {
            case .none: return "square.grid.3x3.square"
            case .touchID: return "touchid"
            case .faceID: return "faceid"
        }
    }
}

