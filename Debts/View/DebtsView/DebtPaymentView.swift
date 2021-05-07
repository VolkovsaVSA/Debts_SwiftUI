//
//  DebtPaymentView.swift
//  Debts
//
//  Created by Sergei Volkov on 05.05.2021.
//

import SwiftUI

struct DebtPaymentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var debtorsDebt: DebtorsDebtsViewModel
    
    @ObservedObject var debtPaymentVM = DebtPaymentViewModel()
    
    var body: some View {
        
        NavigationView {
            
            Form {
                DebtDatailSection(debt: debtorsDebt.selectedDebt!)
                
                Section(header: Text("Payment")) {
                    VStack(alignment: .leading, spacing: 12) {
                        TextField("Amount of payment", text: $debtPaymentVM.amountOfPayment)
                        DatePicker("Date", selection: $debtPaymentVM.dateOfPayment)
                    }
                    .padding(.top, 4)
                    
                }
            }
            
                .modifier(CancelSaveNavBar(navTitle: NSLocalizedString("Payment", comment: "navTitle"),
                                           cancelAction: {
                                            presentationMode.wrappedValue.dismiss()
                                           },
                                           saveAction: {
                                            savePayment()
                                           }))
        }
        
    }
    
    private func savePayment() {
        debtPaymentVM.createPayment(debt: debtorsDebt.selectedDebt!)
        CDStack.shared.saveContext(context: viewContext)
        presentationMode.wrappedValue.dismiss()
    }
    
}

