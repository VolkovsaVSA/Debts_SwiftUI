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
    
    @EnvironmentObject private var currencyVM: CurrencyViewModel
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
    
    @State private var tempTFNewValue = 0.0
    
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
        } else if debt.interestBalance(defaultLastDate: debtPaymentVM.dateOfPayment) == 0 {
            sliderValue = 0
            sliderIsDisable = true
        } else {
            sliderIsDisable = false
        }
        
        if (debt.debtBalance + debt.interestBalance(defaultLastDate: debtPaymentVM.dateOfPayment)) == 0 {
            selectedPaymentType = 1
            penaltyPickerDisabled = true
        } else if debt.penaltyBalance(toDate: debtPaymentVM.dateOfPayment) == 0 {
            selectedPaymentType = 0
            penaltyPickerDisabled = true
        }
    }
    private func calculatePaymentPart() {
        debtPaymentVM.amountOfDebt = (debtPaymentVM.payment * (1 - sliderValue))
            .round(to: 2)
        debtPaymentVM.amountOfIneterst = (debtPaymentVM.payment * sliderValue)
            .round(to: 2)
    }
    private func checkWrongPaymentInput(_ newValue: Double) {
        if (debt.percent == 0) && (Decimal(newValue) > debt.debtBalance) {
            debtPaymentVM.payment = Double(truncating: debt.debtBalance as NSNumber)
                .round(to: 2)
            tfID = UUID()
        } else if Decimal(newValue) <= 0 {
            debtPaymentVM.payment = 0
            tfID = UUID()
        }
        if Decimal(newValue) > (debt.debtBalance + debt.interestBalance(defaultLastDate: debtPaymentVM.dateOfPayment)) {
            debtPaymentVM.payment = Double(truncating: (debt.debtBalance + debt.interestBalance(defaultLastDate: debtPaymentVM.dateOfPayment)) as NSNumber)
                .round(to: 2)
            tfID = UUID()
        }
    }
    private func checkWrongPenaltyInput(_ newValue: Decimal) {
        if debt.penaltyBalance(toDate: debtPaymentVM.dateOfPayment) < newValue {
            debtPaymentVM.penaltyPayment = Double(truncating: debt.penaltyBalance(toDate: debtPaymentVM.dateOfPayment) as NSNumber)
                .round(to: 2)
            penaltytfID = UUID()
        }
    }
    private func checkWrongInputForSliderValue(_ newValue: Double) {
        switch newValue {
            case let k where newValue >= Double(truncating: debt.debtBalance as NSNumber).round(to: 2):
                sliderValue = 1 - Double(truncating: debt.debtBalance as NSNumber).round(to: 2) / k
            case let k where newValue >= Double(truncating: debt.interestBalance(defaultLastDate: debtPaymentVM.dateOfPayment) as NSNumber).round(to: 2):
                sliderValue = Double(truncating: debt.interestBalance(defaultLastDate: debtPaymentVM.dateOfPayment) as NSNumber).round(to: 2) / k
            default: break
        }
    }
    private func checkCorrectSliderValue(_ newValue: Double) {
        if newValue < (1 - Double(truncating: debt.debtBalance as NSNumber).round(to: 2) / debtPaymentVM.payment) {
            sliderValue = 1 - (Double(truncating: debt.debtBalance as NSNumber).round(to: 2) / debtPaymentVM.payment).round(to: 6)
        }
        if newValue > (Double(truncating: debt.interestBalance(defaultLastDate: debtPaymentVM.dateOfPayment) as NSNumber).round(to: 2) / debtPaymentVM.payment) {
            sliderValue = (Double(truncating: debt.interestBalance(defaultLastDate: debtPaymentVM.dateOfPayment) as NSNumber).round(to: 2) / debtPaymentVM.payment).round(to: 6)
        }
    }
    private func showInputWarning(message: String) {
        debtPaymentVM.alertTitle = LocalStrings.Alert.Title.error
        debtPaymentVM.alertText = message
        debtPaymentVM.alertPresent = true
    }

    func showCloseDebtAlert() {
        debtPaymentVM.alertTitle = LocalStrings.Alert.Title.attention
        debtPaymentVM.alertText = LocalStrings.Alert.Text.paymentCoversDebt + debtPaymentVM.dateOfPayment.formatted()
        closeDebtAlert = true
    }
    private func checkCloseDebt() {
        if debt.checkIsPenalty() {
            if debt.debtBalance + debt.interestBalance(defaultLastDate: debtPaymentVM.dateOfPayment) + debt.penaltyBalance(toDate: debtPaymentVM.dateOfPayment) == 0 {
                showCloseDebtAlert()
            } else {
                CDStack.shared.saveContext(context: viewContext)
                dismiss()
            }
        } else {
            if debt.debtBalance + debt.interestBalance(defaultLastDate: debtPaymentVM.dateOfPayment) == 0 {
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
        debt.closeDate = debtPaymentVM.dateOfPayment
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
    private func checkWrongTFInput(_ newValue: Double) {
        checkWrongPaymentInput(newValue)
        if debt.percent != 0 {
            checkWrongInputForSliderValue(newValue)
        }
        calculatePaymentPart()
    }
    private func calculateMinimumPaymentDate(debt: DebtCD) -> Date {
        var minimumPaymentDate = debt.startDate ?? Date()
        if !debt.allPayments.isEmpty {
            minimumPaymentDate = debt.allPayments.last?.date ?? Date()
        }
        return minimumPaymentDate
    }
    
    
    private func mainPaymentView() -> some View {
        return Form {
            
            if debt.checkIsPenalty() {
                Picker("", selection: $selectedPaymentType.animation()) {
                    Text(LocalStrings.Views.PaymentView.mainDebt).tag(0)
                    Text(LocalStrings.Views.PaymentView.penalty).tag(1)
                }
                .disabled(penaltyPickerDisabled)
                .pickerStyle(.segmented)
                .listRowBackground(
                    Color.clear
                )
            }

            if selectedPaymentType == 0 {
                DebtDetailSection(debt: debt, isPaymentView: true, lastDateForAddedPaymentview: debtPaymentVM.dateOfPayment)
//                    .foregroundColor(penaltyPickerDisabled ? .gray : .primary)
//                    .disabled(penaltyPickerDisabled)
                
                Section(header: Text(LocalStrings.Views.PaymentView.payment)) {
                    VStack(alignment: .leading, spacing: 12) {

                        HStack(spacing: 1) {
                            Text(currencyVM.showCurrencyCode ? Currency.presentCurrency(code: debt.currencyCode).currencyCode : Currency.presentCurrency(code: debt.currencyCode).currencySymbol)
                            TextField(LocalStrings.Views.PaymentView.amountOfPayment, value: $debtPaymentVM.payment, formatter: NumberFormatter.numbers)
                                .id(tfID)
                                .keyboardType(.decimalPad)
                                .onChange(of: debtPaymentVM.payment) { newValue in
                                    tempTFNewValue = newValue
                                    checkWrongTFInput(newValue)
                                }
                        }
     
                        if debt.percent != 0 {
                            Group {
                                HStack {
                                    VStack {
                                        Text(LocalStrings.Debt.Attributes.debt)
                                        Text(debtPaymentVM.amountOfDebt, format: .currency(code: debt.currencyCode))
                                    }
                                    Spacer()
                                    VStack {
                                        Text(LocalStrings.Debt.Attributes.interest)
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
                                            checkCorrectSliderValue(newValue)
                                            calculatePaymentPart()
                                        }
                                        
                                    Text(sliderValue.round(to: 4), format: .percent)
                                }
                            }

                        }
                        
                        DatePicker(LocalStrings.Views.PaymentView.date,
                                   selection: $debtPaymentVM.dateOfPayment,
                                   in: calculateMinimumPaymentDate(debt: debt)...Date())
                            .font(.system(size: 17, weight: .thin, design: .default))
                            .onChange(of: debtPaymentVM.dateOfPayment) { _ in
                                checkWrongTFInput(tempTFNewValue)
                            }
                        
                        TextField(LocalStrings.Debt.Attributes.comment, text: $debtPaymentVM.comment)
                    }
                    .padding(.top, 4)
                    
                }
            } else {
                
                DebtPenaltySection(debt: debt, toDate: debtPaymentVM.dateOfPayment)
                    .id(penaltytfID)
                
                Section(header: Text(LocalStrings.Views.PaymentView.penaltyPayment)) {
                    HStack(spacing: 1) {
                        Text(currencyVM.showCurrencyCode ? Currency.presentCurrency(code: debt.currencyCode).currencyCode : Currency.presentCurrency(code: debt.currencyCode).currencySymbol)
                        TextField("", value: $debtPaymentVM.penaltyPayment, formatter: NumberFormatter.numbers)
                            .keyboardType(.decimalPad)
                            .id(penaltytfID)
                            .onChange(of: debtPaymentVM.penaltyPayment) { newValue in
                                checkWrongPenaltyInput(Decimal(newValue))
                            }
                    }
                    if penaltyPickerDisabled {
                        DatePicker(LocalStrings.Views.PaymentView.date,
                                   selection: $debtPaymentVM.dateOfPayment,
                                   in: calculateMinimumPaymentDate(debt: debt)...Date())
                            .font(.system(size: 17, weight: .thin, design: .default))
                            .onChange(of: debtPaymentVM.dateOfPayment) { _ in
                                penaltytfID = UUID()
                            }
                        TextField(LocalStrings.Debt.Attributes.comment, text: $debtPaymentVM.comment)

                    }
                }.listRowSeparator(.hidden)
                
            }
            
            
        }
        .modifier(CancelSaveNavBar(navTitle: LocalStrings.Views.PaymentView.payment,
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
            Button(LocalStrings.Button.ok, role: .cancel) {}
        } message: {
            Text(debtPaymentVM.alertText)
        }
        .alert(debtPaymentVM.alertTitle, isPresented: $closeDebtAlert) {
            Button(LocalStrings.Button.cancel, role: .cancel) {
                viewContext.rollback()
            }
            Button(LocalStrings.Button.closeDebt, role: .destructive) {
                closeDebt()
            }
        } message: {
            Text(debtPaymentVM.alertText)
        }
        .onDisappear {
            debtPaymentVM.dateOfPayment = Date()
        }

    }

}

