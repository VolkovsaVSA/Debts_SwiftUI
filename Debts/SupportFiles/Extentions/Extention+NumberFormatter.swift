//
//  Extention+NumberFormatter.swift
//  Debts
//
//  Created by Sergei Volkov on 06.06.2021.
//

import Foundation

extension NumberFormatter {
    
    static var numbers: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .none
        formatter.maximumFractionDigits = 2
        return formatter
    }
}
