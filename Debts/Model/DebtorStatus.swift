//
//  DebtorStatus.swift
//  Debts
//
//  Created by Sergei Volkov on 10.04.2021.
//

import Foundation

enum DebtorStatus: String {
    case debtor, creditor
    
    static var debtorLocalString: String {
        NSLocalizedString("Debtor", comment: "")
    }
    static var creditorLocalString: String {
        NSLocalizedString("Creditor", comment: "")
    }

    static func statusCDLocalize (status: String)->String  {
        return status == "debtor" ? debtorLocalString : creditorLocalString
    }

}
