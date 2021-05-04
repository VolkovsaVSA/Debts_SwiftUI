//
//  DebtCD+CoreDataProperties.swift
//  Debts
//
//  Created by Sergei Volkov on 17.04.2021.
//
//

import Foundation
import CoreData


extension DebtCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DebtCD> {
        let fetchRequest = NSFetchRequest<DebtCD>(entityName: "DebtCD")
        let startDateSort = NSSortDescriptor(key: "startDate", ascending: true)
        fetchRequest.sortDescriptors = [startDateSort]
        return fetchRequest
    }
    
    @NSManaged public var endDate: Date?
    @NSManaged public var startDate: Date?
    @NSManaged public var balanceOfDebt: NSDecimalNumber
    @NSManaged public var initialDebt: NSDecimalNumber
    @NSManaged public var isClosed: Bool
    @NSManaged public var percentAmount: NSDecimalNumber?
    @NSManaged public var percentType: Int16
    @NSManaged public var percent: NSDecimalNumber
    @NSManaged public var currencyCode: String
    @NSManaged public var comment: String?
    @NSManaged public var debtorStatus: String
    @NSManaged public var debtor: DebtorCD?
    @NSManaged public var payments: NSOrderedSet?

}

// MARK: Generated accessors for payments
extension DebtCD {

    @objc(addPaymentsObject:)
    @NSManaged public func addToPayments(_ value: PaymentCD)

    @objc(removePaymentsObject:)
    @NSManaged public func removeFromPayments(_ value: PaymentCD)

    @objc(addPayments:)
    @NSManaged public func addToPayments(_ values: NSSet)

    @objc(removePayments:)
    @NSManaged public func removeFromPayments(_ values: NSSet)

}

extension DebtCD : Identifiable {

    var laclizeStartDateAndTime: String {
        return MyDateFormatter.convertDate(date: startDate, dateStyle: .medium, timeStyle: .short)
    }
    var laclizeEndDateAndTime: String {
        return MyDateFormatter.convertDate(date: endDate, dateStyle: .medium, timeStyle: .short)
    }
    var laclizeStartDateShort: String {
        return MyDateFormatter.convertDate(date: startDate, dateStyle: .short, timeStyle: .none)
    }
    var laclizeEndDateShort: String {
        return MyDateFormatter.convertDate(date: endDate, dateStyle: .short, timeStyle: .none)
    }
    
    var fullBalance: Decimal {
        return balanceOfDebt as Decimal
    }
    
}
