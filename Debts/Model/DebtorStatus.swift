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
        LocalStrings.Debtor.Status.debtor
    }
    static var creditorLocalString: String {
        LocalStrings.Debtor.Status.creditor
    }

    static func statusCDLocalize (status: String)->String  {
        return status == debtor.rawValue ? debtorLocalString : creditorLocalString
    }

}
