//
//  DebtPaymentsView.swift
//  Debts
//
//  Created by Sergei Volkov on 16.05.2021.
//

import SwiftUI

struct PaymentsView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var debt: DebtCD
    
    let isEditable: Bool
    
    var body: some View {
        
        if !debt.allPayments.isEmpty {
            Section(header: Text("Payments (\(debt.allPayments.count))")) {
                List {
                    if isEditable {
                        ForEach(debt.allPayments, id:\.self) { payment in
                            PaymentCellView(payment: payment, debt: debt)
                        }
                        .onDelete(perform: onDelete)
                    } else {
                        ForEach(debt.allPayments, id:\.self) { payment in
                            PaymentCellView(payment: payment, debt: debt)
                        }
                    }
                }
                
                if isEditable {
                    if CDStack.shared.container.viewContext.hasChanges {
                        undoButton()
                    }
                }
                
            }

        } else {
            HStack {
                Spacer()
                Text("No payments")
                    .fontWeight(.thin)
                Spacer()
            }
        }
        
    }
    
    private func onDelete(offsets: IndexSet) {
        if !debt.allPayments.isEmpty {
            for index in offsets {
                viewContext.delete(debt.allPayments[index])
            }
//            CDStack.shared.saveContext(context: viewContext)
        }
    }
    
    private func undoButton() -> some View {
        return HStack {
            Spacer()
            Button(action: {
                CDStack.shared.container.viewContext.rollback()
            }, label: {
                Text("Undo delete")
                    .modifier(SimpleButtonModifire(textColor: .white,
                                                   buttonColor: AppSettings.accentColor,
                                                   frameWidth: 160))
            })
            .buttonStyle(PlainButtonStyle())
            Spacer()
        }
    }
}
