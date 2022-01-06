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
            
            Text("Number of overdue debts")
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
    
//    private func calclulateOverdueDebts() -> Int {
//        var counter = 0
//        let closedDebts = debtor.fetchDebts(isClosed: true)
//        let openDebts = debtor.fetchDebts(isClosed: false)
//
//        closedDebts.forEach { debt in
//            if let closeDate = debt.closeDate,
//               let endDate = debt.endDate
//            {
//                if closeDate > endDate {
//                    counter += 1
//                }
//            }
//        }
//        openDebts.forEach { debt in
//            if let endDate = debt.endDate
//            {
//                if Date() > endDate {
//                    counter += 1
//                }
//            }
//        }
//
//        return counter
//    }
}
