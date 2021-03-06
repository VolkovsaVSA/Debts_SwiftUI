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
                                        Label(LocalStrings.Button.delete, systemImage: "trash")
                                    }
                                }
                        }
                    } else {
                        ForEach(debt.allPayments, id:\.self) { payment in
                            PaymentCellView(payment: payment, debt: debt)
                        }
                        if !UserDefaults.standard.bool(forKey: IAPProducts.fullVersion.rawValue) {
                            AdsManager.BannerVC(size: CGSize(width: UIScreen.main.bounds.width - 20, height: 56))
                                .frame(height: 50, alignment: .center)
                                .offset(x: -16)
                        }
                        
                    }
                }

                
            }

        } else {
            HStack {
                Spacer()
                Text(LocalStrings.Views.PaymentView.noPayments)
                    .fontWeight(.thin)
                Spacer()
            }
        }
        
    }

}
