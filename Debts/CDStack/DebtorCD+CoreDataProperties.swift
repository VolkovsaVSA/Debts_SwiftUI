//
//  DebtorCD+CoreDataProperties.swift
//  Debts
//
//  Created by Sergei Volkov on 17.04.2021.
//
//

import Foundation
import CoreData


extension DebtorCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DebtorCD> {
        let fetchRequest = NSFetchRequest<DebtorCD>(entityName: "DebtorCD")
        let startDateSort = NSSortDescriptor(key:"firstName", ascending: true)
        fetchRequest.sortDescriptors = [startDateSort]
        return fetchRequest
    }

    @NSManaged public var email: String?
    @NSManaged public var firstName: String
    @NSManaged public var phone: String?
    @NSManaged public var familyName: String?
    @NSManaged public var debts: NSSet?

}

// MARK: Generated accessors for debts
extension DebtorCD {

    @objc(addDebtsObject:)
    @NSManaged public func addToDebts(_ value: DebtCD)

    @objc(removeDebtsObject:)
    @NSManaged public func removeFromDebts(_ value: DebtCD)

    @objc(addDebts:)
    @NSManaged public func addToDebts(_ values: NSSet)

    @objc(removeDebts:)
    @NSManaged public func removeFromDebts(_ values: NSSet)

}

extension DebtorCD : Identifiable {
    var fullName: String {
        return (familyName != nil) ? (firstName + " " + familyName!) : firstName
    }
    
//    var totalDebt: Decimal {
//        var totalDebt: Decimal = 0
//        
//        if let qqq = debts {
//            qqq.forEach { item in
//                totalDebt += (item as! DebtCD).balanceOfDebt as Decimal
//            }
//            
//        }
//        
//        return totalDebt
//    }
    
    var allDebts: [DebtorsDebtsModel] {
        
        var debtsAmount = [DebtorsDebtsModel]()
        guard let tempArray = debts?.allObjects as? [DebtCD] else {
            print("guard")
            return []
        }
        
        tempArray.forEach { tempDebt in
            
            let tempModel = DebtorsDebtsModel(currencyCode: tempDebt.currencyCode,
                                              amount: tempDebt.debtorStatus == "debtor" ? tempDebt.fullBalance as Decimal : -(tempDebt.fullBalance as Decimal))
            
            if debtsAmount.contains(where: { model in
                if tempDebt.currencyCode == model.currencyCode {
                    return true
                } else {
                    return false
                }
            }) {
                
                guard var temp = debtsAmount.filter({ $0.currencyCode == tempModel.currencyCode }).first else {return}
                temp.amount += tempModel.amount
                
                for (index, value) in debtsAmount.enumerated() {
                    if value.currencyCode == tempModel.currencyCode {
                        debtsAmount[index] = temp
                    }
                }
                
            } else {
                debtsAmount.append(tempModel)
            }

            
        }
        
        
        return debtsAmount
    }
    
    
}
