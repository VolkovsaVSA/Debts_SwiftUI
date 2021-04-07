//
//  DebtorCD+CoreDataProperties.swift
//  Debts
//
//  Created by Sergei Volkov on 01.03.2021.
//
//

import Foundation
import CoreData


extension DebtorCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DebtorCD> {
        return NSFetchRequest<DebtorCD>(entityName: "DebtorCD")
    }

    @NSManaged public var name: String?
    @NSManaged public var isDebtor: Bool
    @NSManaged public var phone: String?
    @NSManaged public var email: String?
    @NSManaged public var debts: NSOrderedSet?

}

// MARK: Generated accessors for debts
extension DebtorCD {

    @objc(insertObject:inDebtsAtIndex:)
    @NSManaged public func insertIntoDebts(_ value: DebtCD, at idx: Int)

    @objc(removeObjectFromDebtsAtIndex:)
    @NSManaged public func removeFromDebts(at idx: Int)

    @objc(insertDebts:atIndexes:)
    @NSManaged public func insertIntoDebts(_ values: [DebtCD], at indexes: NSIndexSet)

    @objc(removeDebtsAtIndexes:)
    @NSManaged public func removeFromDebts(at indexes: NSIndexSet)

    @objc(replaceObjectInDebtsAtIndex:withObject:)
    @NSManaged public func replaceDebts(at idx: Int, with value: DebtCD)

    @objc(replaceDebtsAtIndexes:withDebts:)
    @NSManaged public func replaceDebts(at indexes: NSIndexSet, with values: [DebtCD])

    @objc(addDebtsObject:)
    @NSManaged public func addToDebts(_ value: DebtCD)

    @objc(removeDebtsObject:)
    @NSManaged public func removeFromDebts(_ value: DebtCD)

    @objc(addDebts:)
    @NSManaged public func addToDebts(_ values: NSOrderedSet)

    @objc(removeDebts:)
    @NSManaged public func removeFromDebts(_ values: NSOrderedSet)

}

extension DebtorCD : Identifiable {

}
