//
//  SettingsViewModel.swift
//  Debts
//
//  Created by Sergei Volkov on 19.04.2021.
//

import Foundation

class SettingsViewModel: ObservableObject {
    static let shared = SettingsViewModel()
    
    @Published var showAdditionalInfo = true
    @Published var totalAmountWithInterest = false
}
