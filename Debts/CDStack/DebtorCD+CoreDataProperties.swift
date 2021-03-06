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
    @NSManaged public var image: Data?
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
    
    func fetchDebts(isClosed: Bool) -> [DebtCD] {
        guard let tempArray = debts?.allObjects as? [DebtCD] else {
            print("allDebts guard")
            return []
        }
        return tempArray.filter { $0.isClosed == isClosed }
    }
    
    var fullName: String {
        switch SettingsViewModel.shared.displayingNamesSelection {
            case .first:
                return (familyName != nil) ? (firstName + " " + familyName!) : firstName
            case .family:
                return (familyName != nil) ? (familyName! + " " + firstName) : firstName
        }
    }
    
    var nativeAllDebts: [DebtCD] {
        guard let tempArray = debts?.allObjects as? [DebtCD] else {
            print("allDebts guard")
            return []
        }
        return tempArray
    }
    
    var allDebtsDebtorsDebtsModel: [DebtorsDebtsModel] {
        
        var debtsAmount = [DebtorsDebtsModel]()
        guard let tempArray = debts?.allObjects as? [DebtCD] else {
            print("allDebts guard")
            return []
        }
        
        tempArray.forEach { tempDebt in
            
            // Zero balance no displayed
            guard !tempDebt.isClosed else {return}
            var tempModel: DebtorsDebtsModel!
            tempModel = DebtorsDebtsModel(currencyCode: tempDebt.currencyCode,
                                          amount: tempDebt.debtBalance)
            
            if SettingsViewModel.shared.totalAmountWithInterest {
                tempModel.amount += tempDebt.interestBalance(defaultLastDate: Date())
                if let penaltyBalance = tempDebt.penaltyBalance(toDate: Date()) as Decimal? {
                    tempModel.amount += penaltyBalance
                }
            }
            
            if tempDebt.debtorStatus != DebtorStatus.debtor.rawValue {
                tempModel.amount = -tempModel.amount
            }

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
    
    func calclulateOverdueDebts() -> Int {
        var counter = 0
        let closedDebts = fetchDebts(isClosed: true)
        let openDebts = fetchDebts(isClosed: false)
        
        closedDebts.forEach { debt in
            if let closeDate = debt.closeDate,
               let endDate = debt.endDate
            {
                if closeDate > endDate {
                    counter += 1
                }
            }
        }
        openDebts.forEach { debt in
            if let endDate = debt.endDate
            {
                if Date() > endDate {
                    counter += 1
                }
            }
        }
        
        return counter
    }
    
}
