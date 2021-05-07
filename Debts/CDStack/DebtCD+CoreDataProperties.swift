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
    @NSManaged public var percentAmount: NSDecimalNumber
    @NSManaged public var percentType: Int16
    @NSManaged public var percent: NSDecimalNumber
    @NSManaged public var currencyCode: String
    @NSManaged public var comment: String
    @NSManaged public var debtorStatus: String
    @NSManaged public var debtor: DebtorCD?
    @NSManaged public var payments: NSSet?

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

    var localizeStartDateAndTime: String {
        return MyDateFormatter.convertDate(date: startDate, dateStyle: .medium, timeStyle: .short)
    }
    var localizeEndDateAndTime: String {
        return MyDateFormatter.convertDate(date: endDate, dateStyle: .medium, timeStyle: .short)
    }
    var localizeStartDateShort: String {
        return MyDateFormatter.convertDate(date: startDate, dateStyle: .short, timeStyle: .none)
    }
    var localizeEndDateShort: String {
        return MyDateFormatter.convertDate(date: endDate, dateStyle: .short, timeStyle: .none)
    }
    
    var fullBalance: Decimal {
        return balanceOfDebt as Decimal
    }
    
    var calculatePercentAmount: Decimal {
        
        var amount: Decimal = 0
        var difDays: Int = 0
        
//        if percentAmount as Decimal != 0 {
//            difDays = startDate?.daysBetweenDate(toDate: Date()) ?? 0
//            amount += Decimal(difDays) * convertPercent
//        } else {
//            
//        }
//        
        return amount
    }
    
    var convertPercent: Decimal {
        var dayPercent = Decimal(0)
        switch percentType {
        case 0: dayPercent = percent as Decimal / 365
        case 1: dayPercent = percent as Decimal / 30
        case 2: dayPercent = percent as Decimal / 7
        case 3: dayPercent = percent as Decimal
        default: dayPercent = 0
        }
        return dayPercent
    }
    
    var allPayments: [PaymentCD] {
        return (payments?.allObjects as? [PaymentCD] ?? []).sorted {$0.date! < $1.date!}
    }
    
}
