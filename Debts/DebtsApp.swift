//
//  DebtsApp.swift
//  Debts
//
//  Created by Sergei Volkov on 01.03.2021.
//

import SwiftUI

@main
struct DebtsApp: App {
    let persistenceController = PersistenceController.shared
    @StateObject var viewRouter = ViewRouter()

    var body: some Scene {
        WindowGroup {
            MainTabView(viewRouter: viewRouter)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
