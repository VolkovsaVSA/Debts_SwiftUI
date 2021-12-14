//
//  FeedbackSection.swift
//  Debts
//
//  Created by Sergei Volkov on 13.12.2021.
//

import SwiftUI
import MessageUI

struct FeedbackSection: View {
    @EnvironmentObject private var currencyVM: CurrencyViewModel
    @EnvironmentObject private var settingsVM: SettingsViewModel
    @State private var mailResult: Result<MFMailComposeResult, Error>? = nil
    
    var body: some View {
        
        Section(header: Text("Feedback").fontWeight(.semibold).foregroundColor(.primary)) {
            
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