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
    
    @NSManaged public var id: UUID?
    @NSManaged public var endDate: Date?
    @NSManaged public var startDate: Date?
    @NSManaged public var initialDebt: NSDecimalNumber
    @NSManaged public var isClosed: Bool
    @NSManaged public var percentType: Int16
    @NSManaged public var percentBalanceType: Int16
    @NSManaged public var percent: NSDecimalNumber
    @NSManaged public var currencyCode: String
    @NSManaged public var comment: String
    @NSManaged public var debtorStatus: String
    @NSManaged public var debtor: DebtorCD?
    @NSManaged public var payments: NSSet?
    @NSManaged public var penalty: NSDecimalNumber?
    @NSManaged public var penaltyType: String

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
    
    var currencyFormatter: NumberFormatter {
        
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.numberStyle = .currency
        let xxx = Currency.filteredArrayAllcurrency(code: currencyCode)
        
        if currencyCode == "" {
            formatter.currencyCode = Currency.CurrentLocal.currencyCode
            formatter.currencySymbol = Currency.CurrentLocal.currencySymbol
        } else {
            if !xxx.isEmpty {
                formatter.currencyCode = xxx[0].currencyCode
                formatter.currencySymbol = xxx[0].currencySymbol
            }
        }
        
        return formatter
    }

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
        let localPayments: Decimal = allPayments.reduce(0) { (x, y) in
            x + (y.paymentDebt as Decimal)
        }
        return initialDebt as Decimal - localPayments
    }
    
    var convertedPercentBalanceType: String {
        return percentBalanceType == 0 ? LocalStrings.Views.AddDebtView.initialDebt : LocalStrings.Views.AddDebtView.balanseOfDebt
    }
    
    func calculatePercentAmountFunc(balanceType: Int, calcPercent: Decimal, calcPercentType: Int) -> Decimal {
        var amount: Decimal = 0
        var lastPaymentDate = startDate
        
        func localConvertPercent(tempPercentType: Int, tempPercent: Decimal) -> Decimal {
            var dayPercent = Decimal(0)
            switch tempPercentType {
            case 0: dayPercent = tempPercent / 365
            case 1: dayPercent = tempPercent / 30
            case 2: dayPercent = tempPercent / 7
            case 3: dayPercent = tempPercent
            default: dayPercent = 0
            }
            return dayPercent
        }
        
        func calcPercentPeriod(fromDate: Date?, toDate: Date?, debtAmount: NSDecimalNumber) {
            let difDays = fromDate?.daysBetweenDate(toDate: toDate ?? Date())
            let tempPercent = Decimal(difDays ?? 0) * localConvertPercent(tempPercentType: calcPercentType, tempPercent: calcPercent)
            amount += debtAmount as Decimal * tempPercent/100
        }
        
        if percent as Decimal != 0 {
            if balanceType == 0 {
                calcPercentPeriod(fromDate: startDate,
                                  toDate: Date(),
                                  debtAmount: initialDebt)
            } else {
                if allPayments.isEmpty {
                    calcPercentPeriod(fromDate: startDate,
                                      toDate: Date(),
                                      debtAmount: initialDebt)
                } else {
                    var balance = initialDebt as Decimal
                    
                    allPayments.forEach { payment in
                        balance -= payment.paymentDebt as Decimal
                        calcPercentPeriod(fromDate: lastPaymentDate,
                                          toDate: payment.date,
                                          debtAmount: NSDecimalNumber(decimal: balance))
                        lastPaymentDate = payment.date
                    }
                    calcPercentPeriod(fromDate: lastPaymentDate, toDate: Date(), debtAmount: NSDecimalNumber(decimal: balance))
                }
            }
        }
        
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
