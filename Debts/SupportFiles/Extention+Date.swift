//
//  Extention+Date.swift
//  Debts
//
//  Created by Sergei Volkov on 06.05.2021.
//

import Foundation

extension Date {
    func daysBetweenDate(toDate: Date) -> Int {
        let components = Calendar.current.dateComponents([.day], from: self, to: toDate)
        return components.day ?? 0
    }
}
