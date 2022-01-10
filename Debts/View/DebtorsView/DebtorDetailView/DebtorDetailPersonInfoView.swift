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
    @State private var showPopover = false
    
    @ObservedObject var debtor: DebtorCD

    var body: some View {
        
        ZStack {
            
            Text(LocalStrings.Views.DebtorsView.numberOfOverdueDebts)
                .opacity(showPopover ? 1 : 0)
                .zIndex(showPopover ? 1 : 0)
                .padding(8)
                .background(.ultraThinMaterial)
                .cornerRadius(8)
                .onTapGesture {
                    withAnimation {
                        showPopover = false
                    }
                }
            
            HStack {
                PersonImage(size: 40, image: debtor.image)
                    .padding(6)
                VStack(alignment: .leading, spacing: 6) {
                    Text(LocalStrings.Debtor.Attributes.phone)
                        .fontWeight(.thin)
                    Text(LocalStrings.Debtor.Attributes.email)
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
                
                Button {
                    withAnimation {
                        showPopover.toggle()
                    }
                } label: {
                    Text(debtor.calclulateOverdueDebts().description)
                        .font(.system(size: 12, weight: .bold, design: .default))
                        .foregroundColor(debtor.calclulateOverdueDebts() > 0 ? .red : .green)
                        .padding(6)
                        .background(
                            Circle()
                                .stroke(lineWidth: 1.2)
                                .foregroundColor(debtor.calclulateOverdueDebts() > 0 ? .red : .green)
                        )
                }
            }
            .frame(maxHeight: 44)
            .buttonStyle(.plain)
            .modifier(CellModifire(frameMinHeight: 44, useShadow: false))
            
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

    }

}
