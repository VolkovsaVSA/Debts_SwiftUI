//
//  Extention+String.swift
//  Debts
//
//  Created by Sergei Volkov on 18.04.2021.
//

import Foundation

extension String {
    func replaceComma()->String {
        return self.replacingOccurrences(of: ",", with: ".")
    }
}
