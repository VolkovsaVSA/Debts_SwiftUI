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
    let currencyListVM = CurrencyListViewModel.shared
    let debtorsDebt = DebtorsDebtsViewModel.shared
    
    var body: some Scene {
        WindowGroup {
            MainTabView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(addDebtVM)
                .environmentObject(currencyListVM)
                .environmentObject(debtorsDebt)
        }
    }
}
