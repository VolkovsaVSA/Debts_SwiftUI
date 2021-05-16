//
//  DebtsApp.swift
//  Debts
//
//  Created by Sergei Volkov on 01.03.2021.
//

import SwiftUI

@main
struct DebtsApp: App {
    let persistenceController = CDStack.shared
    let addDebtVM = AddDebtViewModel.shared
    let currencyListVM = CurrencyViewModel.shared
    let debtorsDebtVM = DebtsViewModel.shared
    let settingsVM = SettingsViewModel.shared
    
    var body: some Scene {
        WindowGroup {
            MainTabView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(addDebtVM)
                .environmentObject(currencyListVM)
                .environmentObject(debtorsDebtVM)
                .environmentObject(settingsVM)
        }
    }
}
