//
//  DebtorDetailView.swift
//  Debts
//
//  Created by Sergei Volkov on 17.04.2021.
//

import SwiftUI
import MessageUI

struct DebtorDetailView: View {
    
    @Environment(\.dismiss) var dismiss
    @State private var sheet: SheetType?
    @State private var mailResult: Result<MFMailComposeResult, Error>? = nil
    
    var debtor: DebtorCD
    
    var body: some View {
        
        VStack {
            PersonImage(size: 100)
                .padding()
            Text(debtor.fullName)
                .font(.title)
            
            HStack {
                VStack(alignment: .leading, spacing: 6) {
                    Text("Phone:")
                    Text("Email:")
                }
                VStack(alignment: .leading, spacing: 6) {
                    Button(debtor.phone ?? "n/a") {
                        ConnectionManager.makeACall(number: debtor.phone ?? "")
                    }
//                    .buttonStyle(.plain)
//                    .padding(6)
//                    .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 20))
                    
                    Button(debtor.email ?? "n/a") {
                        if MFMailComposeViewController.canSendMail() {
                            sheet = .sendMail
                        }
                    }

                }
                Spacer()
            }.padding(.top, 6)
            Divider()
            Spacer()
        }
        .padding()
        
        .sheet(item: $sheet) {
            //on dismiss action
        } content: { item in
            switch item {
            case .sendMail:
                MailView(result: $mailResult,
                         recipients: [debtor.email ?? ""],
                         messageBody: String(localized: "Message from \(AppId.displayName ?? "") app"))
            default: EmptyView()
            }
        }
        
        .onDisappear() {
            dismiss()
        }
        
        
        
        .navigationTitle(DebtorStatus.statusCDLocalize(status: "debtor"))
    }
}
