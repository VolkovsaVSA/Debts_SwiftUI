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
        
        ScrollView {
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    PersonImage(size: 50)
                        .padding()
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Phone:")
                        Text("Email:")
                    }
                    VStack(alignment: .leading, spacing: 6) {
                        Button(debtor.phone ?? "n/a") {
                            ConnectionManager.makeACall(number: debtor.phone ?? "")
                        }
                        Button(debtor.email ?? "n/a") {
                            if MFMailComposeViewController.canSendMail() {
                                sheet = .sendMail
                            }
                        }

                    }
                    Spacer()
                }
                Divider()
                
                ForEach(debtor.nativeAllDebts, id: \.self) { debt in
                    VStack(alignment: .leading) {
                        Text(debt.startDate?.description ?? "")
                        Text(debt.debtBalance.description)
                        Text(debt.startDate?.description ?? "")
                        if debt.isClosed {
                            Text("Closed")
                        }
                        
                    }
                }
            }
           
            
            
//            Spacer()
        }
        
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
        
        
        
        .navigationTitle(debtor.fullName)
    }
}
