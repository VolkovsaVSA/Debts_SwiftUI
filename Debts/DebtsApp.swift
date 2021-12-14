//
//  DebtsApp.swift
//  Debts
//
//  Created by Sergei Volkov on 01.03.2021.
//

import SwiftUI
import LocalAuthentication
import CoreMIDI


@main
struct DebtsApp: App {
    let persistenceController = CDStack.shared
    let addDebtVM = AddDebtViewModel.shared
    let currencyListVM = CurrencyViewModel.shared
    let debtorsDebtVM = DebtsViewModel.shared
    let settingsVM = SettingsViewModel.shared

    @State private var accessGranted = false
    
    var body: some Scene {
        WindowGroup {
            
            ZStack {
                
                MainTabView()
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
                    .environmentObject(addDebtVM)
                    .environmentObject(currencyListVM)
                    .environmentObject(debtorsDebtVM)
                    .environmentObject(settingsVM)
                    .preferredColorScheme(.dark)
                
                if !accessGranted && settingsVM.authentication {
                    Color.black
                        .ignoresSafeArea(.all, edges: .all)
                }
                
            }
            .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
                accessGranted = false
                if settingsVM.authentication {
                    authenticate()
                }
            }
            .onAppear {
                if settingsVM.authentication {
                    authenticate()
                }
            }
            
            
        }
    }
    
    
    private func authenticate() {
        let context = LAContext()
        var error: NSError?

        // check whether biometric authentication is possible
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            // it's possible, so go ahead and use it
            let reason = "We need to unlock your data."

            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { [self] success, authenticationError in
                // authentication has now completed
                if success {
                    // authenticated successfully
                    self.accessGranted = true
                } else {
                    // there was a problem
                    self.accessGranted = false
                }
            }
        } else {
            // no biometrics
        }
    }

}
