//
//  AddDebtViewModel.swift
//  Debts
//
//  Created by Sergei Volkov on 10.04.2021.
//

import SwiftUI

final class AddDebtViewModel: ObservableObject {
    
    static let shared = AddDebtViewModel()

    @Published var showActivity = false
    @Published var refreshID = UUID()
    @Published var navTitle = ""
    @Published var image: Data?
    @Published var debtAmount = ""
    var debtAmountDecimal: Decimal {
        return Decimal(Double(debtAmount.replaceComma())?.round(to: 2) ?? 0)
    }
    @Published var debtBalance = ""
    @Published var firstName = ""
    @Published var familyName = ""
    @Published var phone = ""
    @Published var email = ""
    @Published var localDebtorStatus = 0
    @Published var startDate = Date() {
        didSet {
            startDateRange = ...endDate
        }
    }
    @Published var endDate = Date() {
        didSet {
            endDateRange = startDate...
        }
    }
    @Published var startDateRange = ...Date()
    @Published var endDateRange = Date()...
    @Published var comment = ""
    @Published var isInterest = false
    @Published var percent = ""
    var percentDecimal: Decimal {
        return Decimal(Double(percent.replaceComma()) ?? 0)
    }
    @Published var percentBalanceType = 0
    var convertedPercentBalanceType: String {
        return percentBalanceType == 0 ? LocalStrings.Debt.PenaltyType.DynamicType.PercentChargeType.initialDebt : LocalStrings.Views.AddDebtView.balanceOfDebt
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
    
    //penalty section
    @Published var isPenalty = false
    @Published var penaltyType = PenaltyType.fixed
    @Published var penaltyFixedAmount = ""
    var penaltyFixedAmountDecimal: Decimal {
        return Decimal(Double(penaltyFixedAmount.replaceComma())?.round(to: 2) ?? 0)
    }
    @Published var penaltyDynamicValue = ""
    var penaltyDynamicValueDecimal: Decimal {
        return Decimal(Double(penaltyDynamicValue.replaceComma())?.round(to: 2) ?? 0)
    }
    @Published var penaltyDynamicType = PenaltyType.DynamicType.amount
    @Published var penaltyDynamicPeriod = PenaltyType.DynamicType.DynamicPeriod.perDay
    @Published var penaltyDynamicPercentChargeType = PenaltyType.DynamicType.PercentChargeType.initialDebt
    @Published var paidPenalty: Decimal = 0
    
    @Published var showDebtorWarning = false
    @Published var debtorsMatching = Set<DebtorCD>()
    
    var alertTitle = ""
    var alertMessage = ""
    
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
        startDateRange = ...endDate
        endDateRange = startDate...
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
        
        isPenalty = false
        penaltyType = PenaltyType.fixed
        penaltyFixedAmount = ""
        penaltyDynamicValue = ""
        penaltyDynamicType = PenaltyType.DynamicType.amount
        penaltyDynamicPeriod = PenaltyType.DynamicType.DynamicPeriod.perDay
        penaltyDynamicPercentChargeType = PenaltyType.DynamicType.PercentChargeType.initialDebt
        paidPenalty = 0
        showDebtorWarning = false
    }
    func createDebtor() -> DebtorCD {
        return CDStack.shared.createDebtor(context: CDStack.shared.persistentContainer.viewContext,
                                           firstName: firstName,
                                           familyName: familyName,
                                           phone: phone,
                                           email: email,
                                           imageData: image
        )
    }
    func updateDebtor(debtor: DebtorCD) {
        debtor.firstName = firstName
        debtor.familyName = familyName
        debtor.phone = phone
        debtor.email = email
        debtor.image = image
    }
    private func savePenalty(_ debt: DebtCD) {
        switch penaltyType {
            case .fixed:
                debt.penaltyFixedAmount = NSDecimalNumber(decimal: penaltyFixedAmountDecimal)
            case .dynamic:
                debt.penaltyDynamicType = penaltyDynamicType.rawValue
                debt.penaltyDynamicPeriod = penaltyDynamicPeriod.rawValue
                debt.penaltyDynamicPercentChargeType = penaltyDynamicPercentChargeType.rawValue
                debt.penaltyDynamicValue = NSDecimalNumber(decimal: penaltyDynamicValueDecimal)
        }
        if let wrapPaidPenalty = debt.paidPenalty as Decimal? {
            if wrapPaidPenalty != paidPenalty {
                debt.paidPenalty = NSDecimalNumber(decimal: paidPenalty)
            }
        }
    }
    
    func createDebt(debtor: DebtorCD, currencyCode: String)->DebtCD {
        let debt = CDStack.shared.createDebt(context: CDStack.shared.persistentContainer.viewContext,
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
        
        if isPenalty {
            savePenalty(debt)
        }
        return debt
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
        
        if isPenalty {
            savePenalty(debt)
        } else {
            debt.penaltyFixedAmount = nil
            debt.penaltyDynamicType = nil
            debt.penaltyDynamicPeriod = nil
            debt.penaltyDynamicValue = nil
            debt.penaltyDynamicPercentChargeType = nil
        }
        
    }
    
    func checkFirstName() -> Bool {
        if firstName == "" {
            alertTitle = LocalStrings.Alert.Title.error
            alertMessage = LocalStrings.Alert.Text.enterTheNameOfTheDebtor
            alertType = .oneButtonInfo
            return true
        } else {
            return false
        }
    }
    func checkDebtAmount() -> Bool {
        if debtAmountDecimal == 0  {
            alertTitle = LocalStrings.Alert.Title.error
            alertMessage = LocalStrings.Alert.Text.enterTheAmountOfTheDebt
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
            image = debtor.image
        }
    }
    func checkEditableDebt() {
        if let editableDebt = editedDebt {
            navTitle = LocalStrings.NavBar.editDebt
            
            localDebtorStatus = (editableDebt.debtorStatus == DebtorStatus.debtor.rawValue) ? 0 : 1
            
            debtorSectionDisable = true
            firstName = editableDebt.debtor?.firstName ?? ""
            familyName = editableDebt.debtor?.familyName ?? ""
            phone = editableDebt.debtor?.phone ?? ""
            email = editableDebt.debtor?.email ?? ""
            startDate = editableDebt.startDate ?? Date()
            endDate = editableDebt.endDate ?? Date()
            if editableDebt.allPayments.isEmpty {
                startDateRange = ...endDate
                endDateRange = startDate...
            } else {
                startDateRange = ...(editableDebt.allPayments.first?.date ?? endDate)
            }
            comment = editableDebt.comment
            image = editableDebt.debtor?.image
            
            debtAmount = editableDebt.initialDebt.description
            CurrencyViewModel.shared.selectedCurrency = Currency.filteredArrayAllcurrency(code: editableDebt.currencyCode).first ?? Currency.CurrentLocal.localCurrency
            
            if editableDebt.percent != 0 {
                isInterest = true
                percent = editableDebt.percent.description
                selectedPercentType = PercentType(rawValue: Int(editableDebt.percentType)) ?? .perYear
                percentBalanceType = Int(editableDebt.percentBalanceType)
            }
            
            if (editableDebt.penaltyFixedAmount != nil) ||
               (editableDebt.penaltyDynamicType != nil)
            {
                
                isPenalty = true
                if let wrapPenaltyFixedAmount = editableDebt.penaltyFixedAmount {
                    penaltyType = .fixed
                    penaltyFixedAmount = wrapPenaltyFixedAmount.description
                } else {
                    penaltyType = .dynamic
                    
                    if let wrapPenaltyDynamicType = editableDebt.penaltyDynamicType,
                       let wrapPenaltyDynamicPeriod = editableDebt.penaltyDynamicPeriod,
                       let wrapPenaltyDynamicPercentChargeType = editableDebt.penaltyDynamicPercentChargeType,
                       let wrapPenaltyDynamicValue = editableDebt.penaltyDynamicValue
                    {
                        penaltyDynamicType = PenaltyType.DynamicType(rawValue: wrapPenaltyDynamicType) ?? PenaltyType.DynamicType.amount
                        penaltyDynamicPercentChargeType = PenaltyType.DynamicType.PercentChargeType(rawValue: wrapPenaltyDynamicPercentChargeType) ?? PenaltyType.DynamicType.PercentChargeType.initialDebt
                        penaltyDynamicPeriod = PenaltyType.DynamicType.DynamicPeriod(rawValue: wrapPenaltyDynamicPeriod) ?? PenaltyType.DynamicType.DynamicPeriod.perDay
                        penaltyDynamicValue = wrapPenaltyDynamicValue.description
                    }
                    
                }
                
                if let wrapPaidPenalty = editableDebt.paidPenalty as Decimal? {
                    paidPenalty = wrapPaidPenalty
                }
            }

        } else {
            navTitle = LocalStrings.NavBar.addDebt
        }
    }
    
    func calculateDateRange(debt: DebtCD?) {
        func setStandartRange() {
            startDateRange = ...endDate
            endDateRange = startDate...
        }
        if let unwrapDebt = debt {
            if unwrapDebt.allPayments.isEmpty {
                setStandartRange()
            } else {
                startDateRange = ...(unwrapDebt.allPayments.first?.date ?? endDate)
            }
        } else {
            setStandartRange()
        }
    }
    
}
