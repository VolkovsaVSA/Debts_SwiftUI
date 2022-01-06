//
//  SettingsView.swift
//  Debts
//
//  Created by Sergei Volkov on 14.04.2021.
//

import SwiftUI
import MessageUI

struct SettingsView: View {
    @EnvironmentObject private var settingsVM: SettingsViewModel
    @EnvironmentObject private var storeManager: StoreManager
    @State private var mailResult: Result<MFMailComposeResult, Error>? = nil
    
    
    var body: some View {
        
        NavigationView {
            
            Form {
                Group {
                    PurchasesSection()
                    BackupSection()
                    VisualSettingSection()
                    NotificationSection()
                    PrivacySection()
                    FeedbackSection()
                    AboutSection()
                }
                .tint(AppSettings.accentColor)
                .font(.system(size: 17, weight: .light, design: .default))
            }
            .navigationTitle(LocalizedStringKey("Settings"))
        }
        .onAppear {
            storeManager.loadProducts()
        }
        .alert(item: $settingsVM.alert) { alert in
            switch alert {
            case .twoButtonActionCancel:
                return Alert(title: Text("Attention!"),
                             message: Text("Previously, you turned off notifications for this app. Do you want to enable notifications in system settings?"),
                             primaryButton: .default(Text("OK"),
                                                     action: {
                    if let settingsUrl = URL(string: UIApplication.openSettingsURLString) {
                        UIApplication.shared.open(settingsUrl)
                    }
                }),
                             secondaryButton: .cancel(Text("Cancel"), action: {
                    
                }))
            default:
                return Alert(title: Text(""))
            }
        }
        
    }
}
