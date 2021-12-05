//
//  SettingsView.swift
//  Debts
//
//  Created by Sergei Volkov on 14.04.2021.
//

import SwiftUI
import MessageUI

struct SettingsView: View {
    
    @Environment(\.colorScheme) private var colorScheme
    
    @EnvironmentObject var currencyVM: CurrencyViewModel
    @EnvironmentObject var settingsVM: SettingsViewModel
    
    @State private var mailResult: Result<MFMailComposeResult, Error>? = nil
    
    var body: some View {
        
        NavigationView {
            
            List {
                
                Group {
                    Section(header: Text("Visual settings")) {
                        VStack {
                            Toggle("Show currency code", isOn: $currencyVM.showCurrencyCode)
                                .listRowSeparator(.hidden)
                            Toggle("Show additional info", isOn: $settingsVM.showAdditionalInfo)
                                .listRowSeparator(.hidden)
                            Toggle("The total amount of debt with accrued interest and penalties", isOn: $settingsVM.totalAmountWithInterest)
                        }
                        
                    }
                    
                    Section(header: Text("Notifications")) {
                        
                        VStack {
                            Toggle("Send notifications", isOn: $settingsVM.sendNotifications.animation())
                                .listRowSeparator(.hidden)
                            if settingsVM.sendNotifications {
                                Toggle("Send all notifications about the delay of debt at one time", isOn: $settingsVM.changeAllNotificationTime.animation())
                                    .listRowSeparator(.hidden)
                                if settingsVM.changeAllNotificationTime {
                                    DatePicker(
                                        "Notification time",
                                        selection: $settingsVM.allNotificationTime,
                                        displayedComponents: [.hourAndMinute]
                                    )
                                    
                                }
                            }
                        }
                        
                    }
                    
                    Section(header: Text("Feedback")) {
                        
                        VStack {
                            FeedbackButton(buttonText: String(localized: "Send email to the developer"),
                                           systemImage: "envelope",
                                           disableButton: !MFMailComposeViewController.canSendMail()) {
                                if MFMailComposeViewController.canSendMail() {
                                    settingsVM.sheet = .sendMail
                                }
                            }

                            FeedbackButton(buttonText: String(localized: "Rate the app"),
                                           systemImage: "star",
                                           disableButton: false) {
                                ConnectionManager.openUrl(openurl: AppId.appUrl)
                            }
                            
                            FeedbackButton(buttonText: String(localized: "Other applications"),
                                           systemImage: "apps.iphone.badge.plus",
                                           disableButton: false) {
                                ConnectionManager.openUrl(openurl: AppId.developerUrl)
                            }
                        }
                        
                    }
                }
                .lineLimit(nil)
                .modifier(CellModifire(frameMinHeight: 10))
            }
            .listStyle(.plain)
            
            .modifier(BackgroundViewModifire())
            .navigationTitle(LocalizedStringKey("Settings"))
            
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
        
        .sheet(item: $settingsVM.sheet) {
            //on dismiss action
        } content: { item in
            switch item {
            case .sendMail:
                MailView(result: $mailResult,
                         recipients: [AppId.feedbackEmail],
                         messageBody: String(localized: "Feedback on application \"InDebt\""))
            default: EmptyView()
            }
        }
        

        
    }
}
