//
//  SheetType.swift
//  Debts
//
//  Created by Sergei Volkov on 09.04.2021.
//

import Foundation


enum SheetType: Identifiable {
    
    case addDebtViewPresent, contactPicker, debtorsList, debtPayment
    
    var id: Int {
        hashValue
    }
}
