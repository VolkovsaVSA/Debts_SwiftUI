//
//  DebtPaymentsView.swift
//  Debts
//
//  Created by Sergei Volkov on 16.05.2021.
//

import SwiftUI

struct PaymentsView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @StateObject var debt: DebtCD
    
    let isEditable: Bool
    
    var body: some View {
        
        if !debt.allPayments.isEmpty {
            
            Section(
                header: Text("Payments (\(debt.allPayments.count))").fontWeight(.bold).foregroundColor(Color(UIColor.label))
            ) {
                List {
                    
                    if isEditable {
                        ForEach(debt.allPayments, id:\.self) { payment in
                            PaymentCellView(payment: payment, debt: debt)
                                .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                    Button(role: .destructive) {
                                        withAnimation() {
                                            viewContext.delete(payment)
                                        }
                                    } label: {
                                        Label("Delete", systemImage: "trash")
                                    }
                                }
                        }
                   
                    } else {
                        ForEach(debt.allPayments, id:\.self) { payment in
                            PaymentCellView(payment: payment, debt: debt)
                        }
                    }
                }
                
//                if isEditable {
//                    if CDStack.shared.container.viewContext.hasChanges {
//                        undoButton()
//                    }
//                }
                
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
    
    private func undoButton() -> some View {
        return HStack {
            Spacer()
            Button(action: {
                withAnimation {
                    CDStack.shared.container.viewContext.rollback()
                }
            }, label: {
                Text("Undo delete")
                    .modifier(SimpleButtonModifire(textColor: .white,
                                                   buttonColor: AppSettings.accentColor,
                                                   frameWidth: 160))
                    .foregroundColor(.white)
            })
            .buttonStyle(PlainButtonStyle())
            Spacer()
        }
    }
}
