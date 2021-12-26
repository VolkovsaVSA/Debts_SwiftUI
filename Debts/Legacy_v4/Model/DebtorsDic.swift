//
//  DebtorsDic.swift
//  Debts
//
//  Created by Sergey Volkov on 22.10.2019.
//  Copyright © 2019 Sergey Volkov. All rights reserved.
//

import Foundation

// debtors-creditors List
class DebtorsDic {
    var name: String
    var summ: Double
    var status: String
    var currencyCode: String
    var phone: String
    var userImage: Data
    
    init(name: String, summ: Double, status: String, currencycode: String, phone: String, userImage: Data) {
        self.name = name
        self.summ = summ
        self.status = status
        self.currencyCode = currencycode
        self.phone = phone
        self.userImage = userImage
    }
}
