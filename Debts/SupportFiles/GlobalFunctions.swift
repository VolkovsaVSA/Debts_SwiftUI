//
//  GlobalFunctions.swift
//  Debts
//
//  Created by Sergei Volkov on 01.06.2021.
//

import Foundation

//struct GlobalFunctions {
//    
//    static func calculatePercentAmountFunc(debt: DebtCD, balanceType: Int) -> Decimal {
//        var amount: Decimal = 0
//        var lastPaymentDate = debt.startDate
//        
//        func calcPercentPeriod(startDate: Date?, toDate: Date?) {
//            let difDays = startDate?.daysBetweenDate(toDate: Date()) ?? 0
//            let tempPercent = Decimal(difDays) * debt.convertPercent
//            amount += debt.initialDebt as Decimal * tempPercent/100
//        }
//        
//        if debt.percent as Decimal != 0 {
//            if balanceType == 0 {
//                calcPercentPeriod(startDate: debt.startDate, toDate: Date())
//                print(amount)
//            } else {
//                if debt.allPayments.isEmpty {
//                    calcPercentPeriod(startDate: debt.startDate, toDate: Date())
//                } else {
//                    debt.allPayments.forEach { payment in
//                        calcPercentPeriod(startDate: lastPaymentDate, toDate: payment.date)
//                        lastPaymentDate = payment.date
//                    }
//                    calcPercentPeriod(startDate: lastPaymentDate, toDate: Date())
//                }
//            }
//        }
//        
//        print(debt.description)
//        print(balanceType)
//        print(amount)
//        print(lastPaymentDate)
//        
//        return amount
//    }
//    
//}
