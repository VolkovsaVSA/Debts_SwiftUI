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
//    @NSManaged public var imageBinaryData: ImageCD?

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
        return (familyName != nil) ? (firstName + " " + familyName!) : firstName
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
                if let penaltyBalance = tempDebt.penaltyBalance as Decimal? {
                    tempModel.amount += penaltyBalance
                }
            }
            
            if tempDebt.debtorStatus != "debtor" {
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
    
//    var loadedImageData: Data? {
//        if let unwrapImageName = image as String? {
//            switch DataManager.loadImage(fileName: unwrapImageName) {
//                case .success(let imageData):
//                    return imageData
//                case .failure(let error):
//                    print(error.localizedDescription)
//                    return nil
//            }
//        } else {
//            return nil
//        }
//    }
//    func saveImage(imageData: Data?) {
//        if let unwrapImage = imageData {
//            switch DataManager.saveImage(fileName: UUID().uuidString, imageData: unwrapImage) {
//                case .success(let imageName):
//                    image = imageName
//                case .failure(let error):
//                    print(error.localizedDescription)
//            }
//        }
//    }
    
}
