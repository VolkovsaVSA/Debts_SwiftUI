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
    
    @EnvironmentObject var currencyVM: CurrencyViewModel
    @ObservedObject var debtPaymentVM = DebtPaymentViewModel()
    
    @ObservedObject var debt: DebtCD
    let isEditableDebt: Bool
    
    
    var body: some View {
        
        if isEditableDebt {
            mainPaymentView()
        } else {
            NavigationView {
                mainPaymentView()
            }
        }
        
        
        
    }
    
    private func mainPaymentView() -> some View {
        return Form {
            
            DebtDetailSection(debt: debt)
            
            Section(header: Text("Payment")) {
                VStack(alignment: .leading, spacing: 12) {

                    HStack(spacing: 1) {
                        Text(currencyVM.showCurrencyCode ? Currency.presentCurrency(code: debt.currencyCode).currencyCode : Currency.presentCurrency(code: debt.currencyCode).currencySymbol)
                        TextField("Amount of payment", value: $debtPaymentVM.amountOfPayment, formatter: NumberFormatter.numbers)
                            .keyboardType(.decimalPad)
                    }
 
                    
//                    Slider(value: $sliderValue, in: -100...100)
                    
                    DatePicker("Date",
                               selection: $debtPaymentVM.dateOfPayment,
                               in: (debt.startDate ?? Date())...Date())
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
                                   }, noCancelButton: isEditableDebt))
        .modifier(OneButtonAlert(title: debtPaymentVM.alertTitle,
                                 text: debtPaymentVM.alertText,
                                 alertType: debtPaymentVM.alert))
    }
    
    private func savePayment() {
        
        if debtPaymentVM.amountOfPayment == 0 {
            debtPaymentVM.alert = .oneButtonInfo
            debtPaymentVM.alertTitle = LocalStrings.Alert.Title.error
            debtPaymentVM.alertText = LocalStrings.Alert.Text.enterTheAmountOfPayment
            return
        } else if Decimal(debtPaymentVM.amountOfPayment) > debt.fullBalance {
            debtPaymentVM.alert = .oneButtonInfo
            debtPaymentVM.alertTitle = LocalStrings.Alert.Title.error
            debtPaymentVM.alertText = LocalStrings.Alert.Text.paymentLessBalance
            return
        }
        
        debtPaymentVM.createPayment(debt: debt)
        CDStack.shared.saveContext(context: viewContext)
        presentationMode.wrappedValue.dismiss()
    }
    
}

