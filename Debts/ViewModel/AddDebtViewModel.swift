//
//  AddDebtViewModel.swift
//  Debts
//
//  Created by Sergei Volkov on 10.04.2021.
//

import Foundation

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
    
    var debtAmountDecimal: Decimal {
        return Decimal(string: debtAmount) ?? 0
    }
    var percentDecimal: Decimal? {
        return Decimal(string: percent)
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
    func createDebtor()->Debtor {
        return Debtor(fristName: firstName,
                      familyName: familyName,
                      phone: phone,
                      email: email,
                      debtorStatus: convertLocalDebtStatus,
                      debts: [])
    }
    func createDebt(debtor: Debtor, currencyCode: String)->Debt {
        return Debt(initialDebt: debtAmountDecimal,
                    balanceOfDebt: debtAmountDecimal,
                    startDate: startDate,
                    endDate: endDate,
                    isClosed: false,
                    percentType: persentType,
                    percent: percentDecimal,
                    percentAmount: nil,
                    payments: [],
                    debtor: debtor,
                    currencyCode: currencyCode,
                    comment: comment)
    }
}
