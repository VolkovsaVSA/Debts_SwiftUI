//
//  PaymentCD+CoreDataProperties.swift
//  Debts
//
//  Created by Sergei Volkov on 01.03.2021.
//
//

import Foundation
import CoreData


extension PaymentCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PaymentCD> {
        return NSFetchRequest<PaymentCD>(entityName: "PaymentCD")
    }

    @NSManaged public var amount: NSDecimalNumber?
    @NSManaged public var paymentDate: Date?
    @NSManaged public var debt: DebtCD?

}

extension PaymentCD : Identifiable {

}
