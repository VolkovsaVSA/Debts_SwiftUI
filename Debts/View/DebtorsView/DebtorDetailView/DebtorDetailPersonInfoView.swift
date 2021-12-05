//
//  DebtorDetailPersonInfoView.swift
//  Debts
//
//  Created by Sergei Volkov on 05.12.2021.
//

import SwiftUI
import MessageUI

struct DebtorDetailPersonInfoView: View {
    
    @State private var sheet: SheetType?
    @State private var mailResult: Result<MFMailComposeResult, Error>? = nil
    
    var debtor: DebtorCD

    var body: some View {
        HStack {
            PersonImage(size: 40)
                .padding(6)
            VStack(alignment: .leading, spacing: 6) {
                Text("Phone:")
                    .fontWeight(.thin)
                Text("Email:")
                    .fontWeight(.thin)
            }
            VStack(alignment: .leading, spacing: 6) {
                Button {
                    ConnectionManager.makeACall(number: debtor.phone ?? "")
                } label: {
                    Text("**\(debtor.phone ?? "")**")
                }

                Button {
                    if MFMailComposeViewController.canSendMail() {
                        sheet = .sendMail
                    }
                } label: {
                    Text("**\(debtor.email ?? "")**")
                }
            }
            Spacer()
        }
        .frame(maxHeight: 44)
        .buttonStyle(.plain)
        .modifier(CellModifire(frameMinHeight: 44))
        
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
        
    }
}
