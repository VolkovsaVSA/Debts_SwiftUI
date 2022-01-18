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
        
        Section(header: Text(LocalStrings.Views.Settings.feedback).fontWeight(.semibold).foregroundColor(.primary)) {
            
            VStack {
                FeedbackButton(buttonText: LocalStrings.Views.Settings.sendEmailToTheDeveloper,
                               systemImage: "envelope",
                               disableButton: !MFMailComposeViewController.canSendMail(),
                               backgroundColor: .blue) {
                    if MFMailComposeViewController.canSendMail() {
                        settingsVM.sheet = .sendMail
                    }
                }

                FeedbackButton(buttonText: LocalStrings.Views.Settings.rateTheApp,
                               systemImage: "star",
                               disableButton: false,
                               backgroundColor: .yellow) {
                    ConnectionManager.openUrl(openurl: AppId.appUrl)
                }
                
                FeedbackButton(buttonText: LocalStrings.Views.Settings.otherApplications,
                               systemImage: "apps.iphone.badge.plus",
                               disableButton: false,
                               backgroundColor: Color.indigo) {
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
                         messageBody: LocalStrings.Other.feedbackOnApplication)
            default: EmptyView()
            }
        }
    }
    
}
