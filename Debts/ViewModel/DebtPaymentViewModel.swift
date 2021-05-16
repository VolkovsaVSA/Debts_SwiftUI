//
//  DebtPaymentViewModel.swift
//  Debts
//
//  Created by Sergei Volkov on 07.05.2021.
//

import Foundation

class DebtPaymentViewModel: ObservableObject {
    
    @Published var amountOfPayment = ""
    @Published var dateOfPayment = Date()
    @Published var comment = ""
    
    @Published var alert: AlertType?
    @Published var alertTitle = ""
    @Published var alertText = ""
    
    var amountOfPaymentDecimal: Decimal {
        return Decimal(Double(amountOfPayment.replaceComma()) ?? 0)
    }
    
    func createPayment(debt: DebtCD) {
        CDStack.shared.createPayment(context: CDStack.shared.container.viewContext,
                                     debt: debt,
                                     amount: NSDecimalNumber(decimal: amountOfPaymentDecimal),
                                     date: dateOfPayment,
                                     type: 0,
                                     comment: comment)
    }
    
    
}
