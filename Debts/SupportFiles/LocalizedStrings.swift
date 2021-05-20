//
//  LocalizedStrings.swift
//  Debts
//
//  Created by Sergei Volkov on 16.05.2021.
//

import Foundation

struct LocalizedStrings {
    struct Alert {
        struct Title {
            static let error = NSLocalizedString("Error", comment: "alert title")
        }
        struct Text {
            static let enterTheNameOfTheDebtor = NSLocalizedString("Enter the name of the debtor.", comment: "alert message")
            static let enterTheAmountOfTheDebt = NSLocalizedString("Enter the amount of the debt.", comment: "alert message")
            static let enterTheAmountOfPayment = NSLocalizedString("Enter the amount of payment.", comment: "alert message")
            static let paymentLessBalance = NSLocalizedString("The amount of the payment should not be more than the balance of the debt!", comment: "alert message")
        }
    }
    struct Views {
        struct AddDebtView {
            static let initialDebt = NSLocalizedString("Initial debt", comment: "")
            static let balanseOfDebt = NSLocalizedString("Balance of debt", comment: "")
        }
    }
}
