//
//  DebtPaymentViewModel.swift
//  Debts
//
//  Created by Sergei Volkov on 07.05.2021.
//

import Foundation

final class DebtPaymentViewModel: ObservableObject {
    
    @Published var payment: Double = 0
    @Published var amountOfDebt: Double = 0
    @Published var amountOfIneterst: Double = 0
    @Published var dateOfPayment = Date()
    @Published var comment = ""
    @Published var alert: AlertType?
    @Published var alertTitle = ""
    @Published var alertText = ""
    @Published var alertPresent = false
    
    @Published var penaltyPayment: Double = 0
    
    func createPayment(debt: DebtCD) {
        CDStack.shared.createPayment(context: CDStack.shared.persistentContainer.viewContext,
                                     debt: debt,
                                     debtAmount: NSDecimalNumber(decimal: Rnd(amountOfDebt)),
                                     interestAmount: NSDecimalNumber(decimal: Rnd(amountOfIneterst)),
                                     date: dateOfPayment,
                                     type: 0,
                                     comment: comment)
    }
    
}
