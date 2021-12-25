//
//  DebtsApp.swift
//  Debts
//
//  Created by Sergei Volkov on 01.03.2021.
//

import SwiftUI
import LocalAuthentication
//import CoreMIDI


@main
struct DebtsApp: App {
    let persistenceController = CDStack.shared
    let addDebtVM = AddDebtViewModel.shared
    let currencyListVM = CurrencyViewModel.shared
    let debtorsDebtVM = DebtsViewModel.shared
    let settingsVM = SettingsViewModel.shared
    let storeManager = StoreManager.shared

    @State private var accessGranted = false
    
    
    var body: some Scene {
        WindowGroup {
            
            ZStack {
                
                MainTabView()
                    .environment(\.managedObjectContext, persistenceController.persistentContainer.viewContext)
                    .environmentObject(addDebtVM)
                    .environmentObject(currencyListVM)
                    .environmentObject(debtorsDebtVM)
                    .environmentObject(settingsVM)
                    .environmentObject(storeManager)
                    .modifier(ChooseColorSchemeViewModifire())
                
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
            .onReceive(NotificationCenter.default.publisher(for: .NSPersistentStoreRemoteChange), perform: { _ in
                debtorsDebtVM.refreshData()
            })
            .onAppear {
                checkBiomentry()
                if settingsVM.authentication {
                    authenticate()
                }
            }
            
        }
    }
    
    private func checkBiomentry() {
        let context = LAContext()
        var error: NSError?
        
        switch context.biometryType {
            case .none:
                SettingsViewModel.shared.biometry = .none
            case .touchID:
                SettingsViewModel.shared.biometry = .touchID
            case .faceID:
                SettingsViewModel.shared.biometry = .faceID
            @unknown default:
                SettingsViewModel.shared.biometry = .none
        }
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            
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

