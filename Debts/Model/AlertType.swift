//
//  ActionType.swift
//  Debts
//
//  Created by Sergei Volkov on 18.04.2021.
//

import Foundation

enum AlertType: Identifiable {
    
    case oneButtonInfo, twoButtonActionCancel
    
    var id: Int {
        hashValue
    }
}
