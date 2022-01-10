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
            .navigationTitle(LocalStrings.NavBar.settings)
        }
        .onAppear {
            storeManager.loadProducts()
        }
        .alert(item: $settingsVM.alert) { alert in
            switch alert {
            case .twoButtonActionCancel:
                    return Alert(title: Text(LocalStrings.Alert.Title.attention),
                                 message: Text(LocalStrings.Alert.Text.previouslyYouTurnedOffNotifications),
                                 primaryButton: .default(Text(LocalStrings.Button.ok),
                                                     action: {
                    if let settingsUrl = URL(string: UIApplication.openSettingsURLString) {
                        UIApplication.shared.open(settingsUrl)
                    }
                }),
                                 secondaryButton: .cancel(Text(LocalStrings.Button.cancel), action: {
                    
                }))
            default:
                return Alert(title: Text(""))
            }
        }
        
    }
}
