//
//  AuthenticationManager.swift
//  Debts
//
//  Created by Sergei Volkov on 13.12.2021.
//

import Foundation
import LocalAuthentication
import SwiftUI


class AuthenticationManager: ObservableObject {
//    static let shared = AuthenticationManager()
    @Published var accessGranted = false
    @Published var refreshedID = UUID()
   
    func authenticate() {
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
                    self.refreshedID = UUID()
                } else {
                    // there was a problem
                    self.accessGranted = false
                    self.refreshedID = UUID()
                }
            }
        } else {
            // no biometrics
        }
    }
}
