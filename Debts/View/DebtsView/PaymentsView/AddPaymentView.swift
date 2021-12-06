//
//  DebtPaymentView.swift
//  Debts
//
//  Created by Sergei Volkov on 05.05.2021.
//

import SwiftUI

struct AddPaymentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    
    @EnvironmentObject var currencyVM: CurrencyViewModel
    @ObservedObject var debtPaymentVM = DebtPaymentViewModel()
    
    @ObservedObject var debt: DebtCD
    let isEditableDebt: Bool
    
    @State private var sliderValue: Double = 0
    @State private var sliderIsDisable = false
    @State private var tfID = UUID()
    @State private var closeDebtAlert = false
    
    @State private var selectedPaymentType = 0
    @State private var penaltyPickerDisabled = false
    @State private var penaltytfID = UUID()
    
    
    var body: some View {
       
        if isEditableDebt {
            mainPaymentView()
        } else {
            NavigationView {
                mainPaymentView()
                    .onAppear {
                        prepareDebtSlider()
                    }
            }
        }

    }
    
    private func prepareDebtSlider() {
        if debt.debtBalance == 0 {
            sliderValue = 1
            sliderIsDisable = true
        } else if debt.interestBalance == 0 {
            sliderValue = 0
            sliderIsDisable = true
        } else {
            sliderIsDisable = false
        }
        
        if (debt.debtBalance + debt.interestBalance) == 0 {
            selectedPaymentType = 1
            penaltyPickerDisabled = true
        } else if debt.penaltyBalance == 0 {
            selectedPaymentType = 0
            penaltyPickerDisabled = true
        }
    }
    private func calculatePaymentPart() {
        debtPaymentVM.amountOfDebt = (debtPaymentVM.payment * (1 - sliderValue)).round(to: 2)
        debtPaymentVM.amountOfIneterst = (debtPaymentVM.payment * sliderValue).round(to: 2)
    }
    private func checkWrongPaymentInput(_ newValue: Double) {
        if (debt.percent == 0) && (Decimal(newValue) > debt.debtBalance) {
            debtPaymentVM.payment = Double(truncating: debt.debtBalance as NSNumber).round(to: 2)
            tfID = UUID()
        } else if Decimal(newValue) <= 0 {
            debtPaymentVM.payment = 0
            tfID = UUID()
        }
        
        if Decimal(newValue) > (debt.debtBalance + debt.interestBalance) {
            debtPaymentVM.payment = Double(truncating: (debt.debtBalance + debt.interestBalance) as NSNumber).round(to: 2)
            tfID = UUID()
        }
    }
    private func checkWrongPenaltyInput(_ newValue: Decimal) {
        if debt.penaltyBalance < newValue {
            debtPaymentVM.penaltyPayment = Double(truncating: debt.penaltyBalance as NSNumber).round(to: 2)
            penaltytfID = UUID()
        }
    }
    private func checkWrongInputForSliderValue(_ newValue: Double) {
        switch newValue {
            case let k where newValue >= Double(truncating: debt.debtBalance as NSNumber).round(to: 2):
                sliderValue = 1 - Double(truncating: debt.debtBalance as NSNumber).round(to: 2) / k
            case let k where newValue >= Double(truncating: debt.interestBalance as NSNumber).round(to: 2):
                sliderValue = Double(truncating: debt.interestBalance as NSNumber).round(to: 2) / k.round(to: 2)
            default: break
        }
    }
    private func checkCorrectSliderValue(_ newValue: Double) {
        if newValue < (1 - Double(truncating: debt.debtBalance as NSNumber).round(to: 2) / debtPaymentVM.payment) {
            sliderValue = 1 - (Double(truncating: debt.debtBalance as NSNumber).round(to: 2) / debtPaymentVM.payment)
        }
        
        if newValue > (Double(truncating: debt.interestBalance as NSNumber).round(to: 2) / debtPaymentVM.payment) {
            sliderValue = (Double(truncating: debt.interestBalance as NSNumber).round(to: 2) / debtPaymentVM.payment)
        }
    }
    private func showInputWarning(message: String) {
        debtPaymentVM.alertTitle = LocalStrings.Alert.Title.error
        debtPaymentVM.alertText = message
        debtPaymentVM.alertPresent = true
    }
//    private func checkIsPenalty() -> Bool {
//        return debt.penaltyFixedAmount != nil || debt.penaltyDynamicType != nil
//    }
    func showCloseDebtAlert() {
        debtPaymentVM.alertTitle = LocalStrings.Alert.Title.attention
        debtPaymentVM.alertText = LocalStrings.Alert.Text.paymentCoversDebt
        closeDebtAlert = true
    }
    private func checkCloseDebt() {
        if debt.checkIsPenalty() {
            if debt.debtBalance + debt.interestBalance + debt.penaltyBalance == 0 {
                showCloseDebtAlert()
            } else {
                CDStack.shared.saveContext(context: viewContext)
                dismiss()
            }
        } else {
            if debt.debtBalance + debt.interestBalance == 0 {
                showCloseDebtAlert()
            } else {
                CDStack.shared.saveContext(context: viewContext)
                dismiss()
            }
        }
    }
    private func addPenaltyPayment() {
        if debtPaymentVM.penaltyPayment > 0 {
            //if there was a payment of a fine
            if var wrapPaidPenalty = debt.paidPenalty as Decimal? {
                wrapPaidPenalty += Rnd(debtPaymentVM.penaltyPayment)
                debt.paidPenalty = NSDecimalNumber(decimal: wrapPaidPenalty)
                //if there not was a payment of a fine
            } else {
                debt.paidPenalty = NSDecimalNumber(decimal: Rnd(debtPaymentVM.penaltyPayment))
            }
        }
    }
    private func closeDebt() {
        debt.isClosed = true
        debt.closeDate = Date()
        if let id = debt.id {
            NotificationManager.removeNotifications(identifiers: [id.uuidString])
        }
        CDStack.shared.saveContext(context: viewContext)
        DebtsViewModel.shared.refreshData()
        dismiss()
    }
    private func savePayment() {

        //checking wrong payment input
        if debtPaymentVM.payment < 0 {
            showInputWarning(message: LocalStrings.Alert.Text.enterTheAmountOfPayment)
            return
        }
        //checking wrong penalty input
        if debtPaymentVM.penaltyPayment < 0 {
            showInputWarning(message: LocalStrings.Alert.Text.enterTheAmountOfPenaltyPayment)
            return
        }

        //penalty checking
        if debt.checkIsPenalty() {
            //if debt payment was be
            if debtPaymentVM.payment > 0 {
                debtPaymentVM.createPayment(debt: debt)
                addPenaltyPayment()
            //if was not be debt payment
            } else {
                addPenaltyPayment()
            }

        } else {
            if debtPaymentVM.payment > 0 {
                debtPaymentVM.createPayment(debt: debt)
            }
        }
        
        checkCloseDebt()
    }
    
    
    
    private func mainPaymentView() -> some View {
        return Form {
            
            if debt.checkIsPenalty() {
                Picker("", selection: $selectedPaymentType.animation()) {
                    Text("Main debt").tag(0)
                    Text("Penalty").tag(1)
                }
                .disabled(penaltyPickerDisabled)
                .pickerStyle(.segmented)
                .listRowBackground(
                    Color.clear
                )
            }

            if selectedPaymentType == 0 {
                DebtDetailSection(debt: debt, isPeymentView: true)
                
                Section(header: Text("Payment")) {
                    VStack(alignment: .leading, spacing: 12) {

                        HStack(spacing: 1) {
                            Text(currencyVM.showCurrencyCode ? Currency.presentCurrency(code: debt.currencyCode).currencyCode : Currency.presentCurrency(code: debt.currencyCode).currencySymbol)
                            TextField("Amount of payment", value: $debtPaymentVM.payment, formatter: NumberFormatter.numbers)
                                .id(tfID)
                                .keyboardType(.decimalPad)
                                .onChange(of: debtPaymentVM.payment) { newValue in
                                    calculatePaymentPart()
                                    checkWrongPaymentInput(newValue)
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
            } else {
                
                DebtPenaltySection(debt: debt)
                Section(header: Text("Penalty payment")) {
                    HStack(spacing: 1) {
                        Text(currencyVM.showCurrencyCode ? Currency.presentCurrency(code: debt.currencyCode).currencyCode : Currency.presentCurrency(code: debt.currencyCode).currencySymbol)
                        TextField("", value: $debtPaymentVM.penaltyPayment, formatter: NumberFormatter.numbers)
                            .keyboardType(.decimalPad)
                            .id(penaltytfID)
                            .onChange(of: debtPaymentVM.penaltyPayment) { newValue in
                                checkWrongPenaltyInput(Decimal(newValue))
                            }
                    }
                }
                
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
            Button("OK", role: .cancel) {}
        } message: {
            Text(debtPaymentVM.alertText)
        }
        .alert(debtPaymentVM.alertTitle, isPresented: $closeDebtAlert) {
            Button("Cancel", role: .cancel) {
                viewContext.rollback()
            }
            Button("Close debt", role: .destructive) {
                closeDebt()
            }
        } message: {
            Text(debtPaymentVM.alertText)
        }
        

    }

}

