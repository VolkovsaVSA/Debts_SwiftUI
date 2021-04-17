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
    @NSManaged public var debts: NSOrderedSet?

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
}
