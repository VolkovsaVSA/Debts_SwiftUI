//
//  DebtCD+CoreDataProperties.swift
//  Debts
//
//  Created by Sergei Volkov on 01.03.2021.
//
//

import Foundation
import CoreData


extension DebtCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DebtCD> {
        return NSFetchRequest<DebtCD>(entityName: "DebtCD")
    }

    @NSManaged public var debtInitial: NSDecimalNumber?
    @NSManaged public var dateStart: Date?
    @NSManaged public var dateEnd: Date?
    @NSManaged public var debtBalance: NSDecimalNumber?
    @NSManaged public var percentAmount: NSDecimalNumber?
    @NSManaged public var percentType: String?
    @NSManaged public var isClosed: Bool
    @NSManaged public var debtor: DebtorCD?
    @NSManaged public var payments: NSOrderedSet?

}

// MARK: Generated accessors for payments
extension DebtCD {

    @objc(insertObject:inPaymentsAtIndex:)
    @NSManaged public func insertIntoPayments(_ value: PaymentCD, at idx: Int)

    @objc(removeObjectFromPaymentsAtIndex:)
    @NSManaged public func removeFromPayments(at idx: Int)

    @objc(insertPayments:atIndexes:)
    @NSManaged public func insertIntoPayments(_ values: [PaymentCD], at indexes: NSIndexSet)

    @objc(removePaymentsAtIndexes:)
    @NSManaged public func removeFromPayments(at indexes: NSIndexSet)

    @objc(replaceObjectInPaymentsAtIndex:withObject:)
    @NSManaged public func replacePayments(at idx: Int, with value: PaymentCD)

    @objc(replacePaymentsAtIndexes:withPayments:)
    @NSManaged public func replacePayments(at indexes: NSIndexSet, with values: [PaymentCD])

    @objc(addPaymentsObject:)
    @NSManaged public func addToPayments(_ value: PaymentCD)

    @objc(removePaymentsObject:)
    @NSManaged public func removeFromPayments(_ value: PaymentCD)

    @objc(addPayments:)
    @NSManaged public func addToPayments(_ values: NSOrderedSet)

    @objc(removePayments:)
    @NSManaged public func removeFromPayments(_ values: NSOrderedSet)

}

extension DebtCD : Identifiable {

}
