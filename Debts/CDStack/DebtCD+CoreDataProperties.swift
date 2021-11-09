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

    @nonobjc public class func fetchRequest(isClosed: Bool) -> NSFetchRequest<DebtCD> {
        let fetchRequest = NSFetchRequest<DebtCD>(entityName: "DebtCD")
        let startDateSort = NSSortDescriptor(key: "startDate", ascending: true)
        fetchRequest.sortDescriptors = [startDateSort]
        let predicate = NSPredicate(format: "isClosed == %@", NSNumber(value: isClosed))
        fetchRequest.predicate = predicate
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
    @NSManaged public var penaltyFixedAmount: NSDecimalNumber?
    @NSManaged public var penaltyDynamicValue: NSDecimalNumber?
    @NSManaged public var penaltyDynamicType: String?
    @NSManaged public var penaltyDynamicPeriod: String?
    @NSManaged public var penaltyDynamicPercentChargeType: String?
    
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
    
    var debtBalance: Decimal {
        let localPayments: Decimal = allPayments.reduce(0) { (x, y) in
            x + (y.paymentDebt as Decimal)
        }
        return initialDebt as Decimal - localPayments
    }
    var interestBalance: Decimal {
        let localPayments: Decimal = allPayments.reduce(0) { (x, y) in
            x + (y.paymentPercent as Decimal)
        }
        return calculatePercentAmountFunc(balanceType: Int(percentBalanceType),
                                          calcPercent: percent as Decimal,
                                          calcPercentType: Int(percentType)) - localPayments
    }
    
    var convertedPercentBalanceType: String {
        return percentBalanceType == 0 ? LocalStrings.Views.AddDebtView.initialDebt : LocalStrings.Views.AddDebtView.balanseOfDebt
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
        
        return Decimal(Double(truncating: amount as NSNumber).round(to: 2))
    }
    
    func calcPenalties() -> Decimal {
        
        var penalties: Decimal = 0
        
        guard let difDays = endDate?.daysBetweenDate(toDate: Date()) else { return penalties }
        guard difDays > 0 else { return penalties }
        
        if let fixed = penaltyFixedAmount {
            penalties = fixed as Decimal
        }
        
        if let type = penaltyDynamicType,
           let period = penaltyDynamicPeriod,
           let chargeType = penaltyDynamicPercentChargeType,
           let value = penaltyDynamicValue as Decimal?
        
        {
            let dynType = PenaltyType.DynamicType(rawValue: type)
            let dynPeriod = PenaltyType.DynamicType.DynamicPeriod(rawValue: period)
            let dynChargeType = PenaltyType.DynamicType.PercentChargeType(rawValue: chargeType)
            let periodValue = Decimal(difDays / (dynPeriod == .perDay ? 1 : 7))
            
            switch dynType {
            case .amount:
                penalties = value * periodValue
            case .percent:
                switch dynChargeType {
                case .initialDebt:
                    penalties = initialDebt as Decimal * value * periodValue
                case .balance:
                    penalties = 0
                    
                    var balance = initialDebt as Decimal

                    allPayments.forEach { payment in
                        
                        if endDate ?? Date() < payment.date ?? Date() {
                            penalties += balance * value * periodValue
                        }
                        
                        balance -= payment.paymentDebt as Decimal
                    }
                    
                case .none:
                    break
                }
            case .none:
                break
            }
            
        }
        
        return penalties
    }
    
    
    
}
