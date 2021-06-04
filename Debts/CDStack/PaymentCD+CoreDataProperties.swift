//
//  PaymentCD+CoreDataProperties.swift
//  Debts
//
//  Created by Sergei Volkov on 17.04.2021.
//
//

import Foundation
import CoreData


extension PaymentCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PaymentCD> {
        return NSFetchRequest<PaymentCD>(entityName: "PaymentCD")
    }

    @NSManaged public var paymentDebt: NSDecimalNumber
    @NSManaged public var paymentPercent: NSDecimalNumber
    @NSManaged public var date: Date?
    @NSManaged public var type: Int16
    @NSManaged public var debt: DebtCD?
    @NSManaged public var comment: String

}

extension PaymentCD : Identifiable {
    var localizePaymentDateAndTime: String {
        return MyDateFormatter.convertDate(date: date, dateStyle: .medium, timeStyle: .short)
    }
}
