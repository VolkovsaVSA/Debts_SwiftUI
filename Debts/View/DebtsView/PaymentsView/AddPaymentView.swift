//
//  DebtPaymentView.swift
//  Debts
//
//  Created by Sergei Volkov on 05.05.2021.
//

import SwiftUI

struct AddPaymentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var debtsVM: DebtsViewModel
    
    @ObservedObject var debtPaymentVM = DebtPaymentViewModel()
    
    var body: some View {
        
        if debtsVM.addPaymentPush {
            mainPaymentView()
        } else {
            NavigationView {
                mainPaymentView()
            }
        }
        
        
        
    }
    
    private func mainPaymentView() -> some View {
        return Form {
            DebtDatailSection(debt: debtsVM.selectedDebt!)
            
            Section(header: Text("Payment")) {
                VStack(alignment: .leading, spacing: 12) {
                    TextField("Amount of payment", text: $debtPaymentVM.amountOfPayment)
                        .keyboardType(.decimalPad)
                    DatePicker("Date", selection: $debtPaymentVM.dateOfPayment)
                        .font(.system(size: 17, weight: .thin, design: .default))
                    TextField("Comment", text: $debtPaymentVM.comment)
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
                                   }, noCancelButton: debtsVM.addPaymentPush))
        .modifier(OneButtonAlert(title: debtPaymentVM.alertTitle,
                                 text: debtPaymentVM.alertText,
                                 alertType: debtPaymentVM.alert))
    }
    
    private func savePayment() {
        
        if debtPaymentVM.amountOfPaymentDecimal == 0 {
            debtPaymentVM.alert = .oneButtonInfo
            debtPaymentVM.alertTitle = LocalizedStrings.Alert.Title.error
            debtPaymentVM.alertText = LocalizedStrings.Alert.Text.enterTheAmountOfPayment
            return
        } else if debtPaymentVM.amountOfPaymentDecimal > debtsVM.selectedDebt!.fullBalance {
            debtPaymentVM.alert = .oneButtonInfo
            debtPaymentVM.alertTitle = LocalizedStrings.Alert.Title.error
            debtPaymentVM.alertText = LocalizedStrings.Alert.Text.paymentLessBalance
            return
        }
        
        debtPaymentVM.createPayment(debt: debtsVM.selectedDebt!)
        CDStack.shared.saveContext(context: viewContext)
        debtsVM.refreshData()
        presentationMode.wrappedValue.dismiss()
    }
    
}

