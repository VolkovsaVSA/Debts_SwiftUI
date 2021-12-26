//
//  MigrationManager.swift
//  Debts
//
//  Created by Sergei Volkov on 26.12.2021.
//

import Foundation

struct MigrationManager {

    
    func LoadOldData() -> [Debt] {
        var debtsMass: [Debt] = []
        if let loadArray = NSArray(contentsOfFile: PathForSave.debtData) {
            debtsMass = []
            for itemArray in loadArray {
                let tempData = Debt(dictionary: itemArray as! NSDictionary)
                debtsMass.append(tempData)
            }
        }
        return debtsMass
    }
    func LoadOldHistory() -> [Debt] {
        var historyMass: [Debt] = []
        if let loadArray = NSArray(contentsOfFile: PathForSave.history) {
            historyMass = []
            for itemArray in loadArray {
                let tempData = Debt(dictionary: itemArray as! NSDictionary)
                historyMass.append(tempData)
            }
        }
        return historyMass
    }
    
}
