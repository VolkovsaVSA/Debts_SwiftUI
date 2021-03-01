//
//  DebtsApp.swift
//  Debts
//
//  Created by Sergey Volkov on 01.03.2021.
//

import SwiftUI

@main
struct DebtsApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
