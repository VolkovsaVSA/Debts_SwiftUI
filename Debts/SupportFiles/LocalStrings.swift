//
//  LocalizedStrings.swift
//  Debts
//
//  Created by Sergei Volkov on 16.05.2021.
//

import Foundation
import SwiftUI

struct LocalStrings {
    
    static func purchesingWarning(price: String) -> LocalizedStringKey {
        LocalizedStringKey("Purchasing the full version for \(price)")
    }
    
    struct Alert {
        struct Title {
            static let error = NSLocalizedString("Error", comment: "alert title")
            static let attention = NSLocalizedString("Attention", comment: "alert title")
            static let purchasingFullVersion = NSLocalizedString("Purchasing the full version", comment: "alert title")
        }
        struct Text {
            static let enterTheNameOfTheDebtor = NSLocalizedString("Enter the name of the debtor.", comment: "alert message")
            static let enterTheAmountOfTheDebt = NSLocalizedString("Enter the amount of the debt.", comment: "alert message")
            static let enterTheAmountOfPayment = NSLocalizedString("Enter the amount of payment.", comment: "alert message")
            static let enterTheAmountOfPenaltyPayment = NSLocalizedString("Enter the amount of penalty payment.", comment: "alert message")
            static let paymentLessBalance = NSLocalizedString("The amount of the payment should not be more than the balance of the debt!", comment: "alert message")
            static let paymentCoversDebt = String(localized: "This payment covers the debt! The debt will be closed ")
            static let purchaseFullVersionWarning = NSLocalizedString("When you purchase the full version of the application, all the application functions will be available to you, and the ads will not be displayed.", comment: "alert message")
        }
    }
    struct Views {
        struct AddDebtView {
            static let initialDebt = NSLocalizedString("Initial debt", comment: "")
            static let balanceOfDebt = NSLocalizedString("Balance of debt", comment: "")
        }
    }
    
    struct Period {
        static let perDay = String(localized: "per day")
        static let perWeek = String(localized: "per week")
        static let perMonth = String(localized: "per month")
        static let perYear = String(localized: "per year")
    }
}
