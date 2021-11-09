//
//  DebtPaymentView.swift
//  Debts
//
//  Created by Sergei Volkov on 05.05.2021.
//

import SwiftUI

struct AddPaymentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) var dismiss
    
    @EnvironmentObject var currencyVM: CurrencyViewModel
    @ObservedObject var debtPaymentVM = DebtPaymentViewModel()
    
    @ObservedObject var debt: DebtCD
    let isEditableDebt: Bool
    
    @State var sliderValue: Double = 0
    @State var sliderIsDisable = false
    @State var tfID = UUID()
    @State var closeDebtAlert = false

    var body: some View {
        
        if isEditableDebt {
            mainPaymentView()
        } else {
            NavigationView {
                mainPaymentView()
                    .onAppear {
                        
                        if debt.debtBalance == 0 {
                            sliderValue = 1
                            sliderIsDisable = true
                        } else if debt.interestBalance == 0 {
                            sliderValue = 0
                            sliderIsDisable = true
                        } else {
                            sliderIsDisable = false
                        }
                        
                    }
            }
        }

    }
    
    private func calculatePaymentPart() {
        debtPaymentVM.amountOfDebt = (debtPaymentVM.payment * (1 - sliderValue)).round(to: 2)
        debtPaymentVM.amountOfIneterst = (debtPaymentVM.payment * sliderValue).round(to: 2)
    }
    private func checkWrongRangeInput(_ newValue: Double) {
        if (debt.percent == 0) && (Decimal(newValue) > debt.debtBalance) {
            debtPaymentVM.payment = Double(truncating: debt.debtBalance as NSNumber)
            tfID = UUID()
        } else if Decimal(newValue) <= 0 {
            debtPaymentVM.payment = 0
            tfID = UUID()
        }
        
        if Decimal(newValue) > (debt.debtBalance + debt.interestBalance) {
            debtPaymentVM.payment = Double(truncating: (debt.debtBalance + debt.interestBalance) as NSNumber)
            tfID = UUID()
        }
    }
    private func checkWrongInputForSliderValue(_ newValue: Double) {
        switch newValue {
            case let k where newValue >= Double(truncating: debt.debtBalance as NSNumber):
                sliderValue = 1 - Double(truncating: debt.debtBalance as NSNumber) / k
            case let k where newValue >= Double(truncating: debt.interestBalance as NSNumber):
                sliderValue = Double(truncating: debt.interestBalance as NSNumber).round(to: 2) / k.round(to: 2)
            default: break
        }
    }
    
    fileprivate func checkCorrectSliderValue(_ newValue: Double) {
        if newValue < (1 - Double(truncating: debt.debtBalance as NSNumber) / debtPaymentVM.payment) {
            sliderValue = 1 - (Double(truncating: debt.debtBalance as NSNumber) / debtPaymentVM.payment)
        }
        
        if newValue > (Double(truncating: debt.interestBalance as NSNumber) / debtPaymentVM.payment) {
            sliderValue = (Double(truncating: debt.interestBalance as NSNumber) / debtPaymentVM.payment)
        }
    }
    
    private func mainPaymentView() -> some View {
        return Form {
            
            DebtDetailSection(debt: debt)
            
            Section(header: Text("Payment")) {
                VStack(alignment: .leading, spacing: 12) {

                    HStack(spacing: 1) {
                        Text(currencyVM.showCurrencyCode ? Currency.presentCurrency(code: debt.currencyCode).currencyCode : Currency.presentCurrency(code: debt.currencyCode).currencySymbol)
                        TextField("Amount of payment", value: $debtPaymentVM.payment, formatter: NumberFormatter.numbers)
                            .id(tfID)
                            .keyboardType(.decimalPad)
                            .onChange(of: debtPaymentVM.payment) { newValue in
                                calculatePaymentPart()
                                checkWrongRangeInput(newValue)
                                if debt.percent != 0 {
                                    checkWrongInputForSliderValue(newValue)
                                }
                            }
                    }
 
                    if debt.percent != 0 {
                        HStack {
                            VStack {
                                Text("Debt")
                                Text(debtPaymentVM.amountOfDebt, format: .currency(code: debt.currencyCode))
                            }
                            Spacer()
                            VStack {
                                Text("Interest")
                                Text(debtPaymentVM.amountOfIneterst, format: .currency(code: debt.currencyCode))
                            }
                            
                        }
                        .foregroundColor(.gray)
                        HStack {
                            Text((1 - sliderValue.round(to: 4)), format: .percent)
                            Slider(value: $sliderValue, in: 0...1, step: 0.01)
                                .accentColor(sliderIsDisable ? .gray : .blue)
                                .disabled(sliderIsDisable)
                                .id(!sliderIsDisable)
                                .onChange(of: sliderValue) { newValue in
                                    calculatePaymentPart()
                                    checkCorrectSliderValue(newValue)
                                }
                                
                            Text(sliderValue.round(to: 4), format: .percent)
                        }
                    }
                    
                    
                    
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
                                    dismiss()
                                   },
                                   saveAction: {
                                    savePayment()
                                   }, noCancelButton: isEditableDebt))
        .modifier(OneButtonAlert(title: debtPaymentVM.alertTitle,
                                 text: debtPaymentVM.alertText,
                                 alertType: debtPaymentVM.alert))
        .alert(debtPaymentVM.alertTitle, isPresented: $debtPaymentVM.alertPresent) {
            Button("OK") {}
        } message: {
            Text(debtPaymentVM.alertText)
        }
        .alert(debtPaymentVM.alertTitle, isPresented: $closeDebtAlert) {
            Button("Close debt", role: .destructive) {
                debt.isClosed = true
                if let id = debt.id {
                    NotificationManager.removeNotifications(identifiers: [id.uuidString])
                }
                debtPaymentVM.createPayment(debt: debt)
                CDStack.shared.saveContext(context: viewContext)
                dismiss()
            }
        } message: {
            Text(debtPaymentVM.alertText)
        }

    }
    
    private func savePayment() {
        
        if debtPaymentVM.payment <= 0 {
            debtPaymentVM.alertTitle = LocalStrings.Alert.Title.error
            debtPaymentVM.alertText = LocalStrings.Alert.Text.enterTheAmountOfPayment
            debtPaymentVM.alertPresent = true
            return
        }

        if  Rnd(debtPaymentVM.payment) == (debt.debtBalance + debt.interestBalance) {
            debtPaymentVM.alertTitle = LocalStrings.Alert.Title.attention
            debtPaymentVM.alertText = LocalStrings.Alert.Text.paymentCoversDebt
            closeDebtAlert = true
        } else {
            debtPaymentVM.createPayment(debt: debt)
            CDStack.shared.saveContext(context: viewContext)
            dismiss()
        }

        
    }
    
}

