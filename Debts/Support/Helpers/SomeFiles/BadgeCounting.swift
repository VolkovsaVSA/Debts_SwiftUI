//
//  BadgeCounting.swift
//  Debts
//
//  Created by Sergei Volkov on 14.01.2022.
//

import UIKit

func BadgeCounting(debts: [DebtCD]) {
    var temp = 0
    for debt in debts {
        if Date() > debt.endDate ?? Date() {
            temp = temp + 1
        }
    }
    UIApplication.shared.applicationIconBadgeNumber = temp
}
