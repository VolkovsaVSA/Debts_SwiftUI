//
//  AddDebtViewModel.swift
//  Debts
//
//  Created by Sergei Volkov on 10.04.2021.
//

import SwiftUI

class AddDebtViewModel: ObservableObject {
    
    static let shared = AddDebtViewModel()
    
    @Published var navTitle = ""
   
    @Published var image: UIImage?
    @Published var debtAmount = ""
    @Published var debtBalance = ""
    @Published var firstName = ""
    @Published var familyName = ""
    @Published var phone = ""
    @Published var email = ""
    @Published var localDebtorStatus = 0
    @Published var startDate = Date()
    @Published var endDate = Date()
    @Published var comment = ""
    
    @Published var isInterest = false
    @Published var percent = ""
    @Published var percentBalanceType = 0
    var convertedPercentBalanceType: String {
        return percentBalanceType == 0 ? LocalizedStrings.Views.AddDebtView.initialDebt : LocalizedStrings.Views.AddDebtView.balanseOfDebt
    }
    @Published var selectedPercentType: PercentType = .perYear {
        didSet {
            isSelectedCurrencyForEditableDebr = true
        }
    }
    
    @Published var alertType: AlertType?
    @Published var sheetType: SheetType?
    
    @Published var selectedDebtor: DebtorCD?
    @Published var editedDebt: DebtCD?
    @Published var debtorSectionDisable = false
    @Published var isSelectedCurrencyForEditableDebr = false
    
    @Published var selectCurrencyPush = false
    
    @Published var addPaymentPush = false
    
    var alertTitle = ""
    var alertMessage = ""
    
    var debtAmountDecimal: Decimal {
        return Decimal(Double(debtAmount.replaceComma()) ?? 0)
    }
    var percentDecimal: Decimal {
        return Decimal(Double(percent.replaceComma()) ?? 0)
    }
    var convertLocalDebtStatus: DebtorStatus {
        return DebtorStatus(rawValue: localDebtorStatus == 0 ? DebtorStatus.debtor.rawValue : DebtorStatus.creditor.rawValue) ?? DebtorStatus.debtor
    }
    var persentType: PercentType? {
        return percent != "" ? selectedPercentType : nil
    }
    
    func resetData() {
        debtAmount = ""
        debtBalance = ""
        firstName = ""
        familyName = ""
        phone = ""
        email = ""
        localDebtorStatus = 0
        startDate = Date()
        endDate = Date()
        percent = ""
        comment = ""
        selectedPercentType = .perYear
        image = nil
        selectedDebtor = nil
        editedDebt = nil
        debtorSectionDisable = false
        isSelectedCurrencyForEditableDebr = false
        CurrencyViewModel.shared.selectedCurrency = Currency.CurrentLocal.localCurrency
        selectCurrencyPush = false
        isInterest = false
        percentBalanceType = 0
    }
    func createDebtor() -> DebtorCD {
        return CDStack.shared.createDebtor(context: CDStack.shared.container.viewContext,
                                           firstName: firstName,
                                           familyName: familyName,
                                           phone: phone,
                                           email: email)
    }
    func updateDebtor(debtor: DebtorCD) {
        debtor.firstName = firstName
        debtor.familyName = familyName
        debtor.phone = phone
        debtor.email = email
    }
    func createDebt(debtor: DebtorCD, currencyCode: String)->DebtCD {
        return CDStack.shared.createDebt(context: CDStack.shared.container.viewContext,
                                         debtor: debtor,
                                         initialDebt: NSDecimalNumber(decimal: debtAmountDecimal),
                                         startDate: startDate,
                                         endDate: endDate,
                                         percent: NSDecimalNumber(decimal: percentDecimal),
                                         percentType: Int16(selectedPercentType.rawValue),
                                         currencyCode: currencyCode,
                                         debtorStatus: convertLocalDebtStatus.rawValue,
                                         comment: comment,
                                         percentBalanceType: Int16(percentBalanceType))
    }
    func updateDebt(debt: DebtCD, currencyCode: String) {
        debt.initialDebt = NSDecimalNumber(decimal: debtAmountDecimal)
        debt.startDate = startDate
        debt.endDate = endDate
        
        if isInterest {
            debt.percent = NSDecimalNumber(decimal: percentDecimal)
            debt.percentType = Int16(selectedPercentType.rawValue)
            debt.currencyCode = currencyCode
            debt.comment = comment
            debt.percentBalanceType = Int16(percentBalanceType)
        } else {
            debt.percent = 0
            debt.percentType = 0
            debt.currencyCode = currencyCode
            debt.comment = comment
            debt.percentBalanceType = 0
        }
        
    }
    
    func checkFirstName() -> Bool {
        if firstName == "" {
            alertTitle = LocalizedStrings.Alert.Title.error
            alertMessage = LocalizedStrings.Alert.Text.enterTheNameOfTheDebtor
            alertType = .oneButtonInfo
            return true
        } else {
            return false
        }
    }
    func checkDebtAmount() -> Bool {
        if debtAmountDecimal == 0  {
            alertTitle = LocalizedStrings.Alert.Title.error
            alertMessage = LocalizedStrings.Alert.Text.enterTheAmountOfTheDebt
            alertType = .oneButtonInfo
            return true
        } else {
            return false
        }
        
    }
    func checkDebtor() {
        if let debtor = selectedDebtor {
            image = nil
            firstName = debtor.firstName
            familyName = debtor.familyName ?? ""
            phone = debtor.phone ?? ""
            email = debtor.email ?? ""
        }
    }
    func checkEditableDebt() {
        if let editableDebt = editedDebt {
            navTitle = NSLocalizedString("Edit debt", comment: "navTitle")
            
            localDebtorStatus = (editableDebt.debtorStatus == DebtorStatus.debtor.rawValue) ? 0 : 1
            
            debtorSectionDisable = true
            firstName = editableDebt.debtor?.firstName ?? ""
            familyName = editableDebt.debtor?.familyName ?? ""
            phone = editableDebt.debtor?.phone ?? ""
            email = editableDebt.debtor?.email ?? ""
            startDate = editableDebt.startDate ?? Date()
            endDate = editableDebt.endDate ?? Date()
            comment = editableDebt.comment
            
            if editableDebt.percent != 0 {
                isInterest = true
            }
            
            percent = editableDebt.percent.description
            selectedPercentType = PercentType(rawValue: Int(editableDebt.percentType)) ?? .perYear
            percentBalanceType = Int(editableDebt.percentBalanceType)

            debtAmount = editableDebt.initialDebt.description
            CurrencyViewModel.shared.selectedCurrency = Currency.filteredArrayAllcurrency(code: editableDebt.currencyCode).first ?? Currency.CurrentLocal.localCurrency
        } else {
            navTitle = NSLocalizedString("Add debt", comment: "navTitle")
        }
    }
}
