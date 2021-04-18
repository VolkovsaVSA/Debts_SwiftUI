//
//  AddDebtViewModel.swift
//  Debts
//
//  Created by Sergei Volkov on 10.04.2021.
//

import SwiftUI

class AddDebtViewModel: ObservableObject {
    @Published var debtAmount = ""
    @Published var firstName = ""
    @Published var familyName = ""
    @Published var phone = ""
    @Published var email = ""
    @Published var localDebtorStatus = 0
    @Published var startDate = Date()
    @Published var endDate = Date()
    @Published var percent = ""
    @Published var comment = ""
    @Published var selectedPercentType: PercentType = .perYear
    
    @Published var alertType: AlertType? {
        didSet {
            if alertType == nil {
                alertTitle = ""
                alertTitle = ""
            }
        }
    }
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
    }
    func createDebtor()->DebtorCD {
        return CDStack.shared.createDebtor(context: CDStack.shared.container.viewContext,
                                           firstName: firstName,
                                           familyName: familyName,
                                           phone: phone,
                                           email: email)
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
                                         comment: comment)
    }
    
    func checkFirstName()->Bool {
        if firstName == "" {
            alertTitle = NSLocalizedString("Error", comment: "alert title")
            alertMessage = NSLocalizedString("Enter the name of the debtor", comment: "alert message")
            alertType = .oneButtonInfo
            return true
        } else {
            return false
        }
    }
    func checkDebtAmount()->Bool {
        if debtAmountDecimal == 0  {
            alertTitle = NSLocalizedString("Error", comment: "alert title")
            alertMessage = NSLocalizedString("Enter the amount of the debt", comment: "alert message")
            alertType = .oneButtonInfo
            return true
        } else {
            return false
        }
        
    }
}
