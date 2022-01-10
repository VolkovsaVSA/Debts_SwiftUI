//
//  PenaltyType.swift
//  Debts
//
//  Created by Sergei Volkov on 14.07.2021.
//

import Foundation

enum PenaltyType: String, CaseIterable {
    case fixed, dynamic
    
    static var fixedLocalString: String {
        LocalStrings.Debt.PenaltyType.fixed
    }
    static var dynamicLocalString: String {
        LocalStrings.Debt.PenaltyType.dynamic
    }
    static func penaltyTypeCDLocalize (type: String) -> String  {
        return type == PenaltyType.fixed.rawValue ? fixedLocalString : dynamicLocalString
    }
    
    enum DynamicType: String, CaseIterable {
        case amount, percent
        
        static var amountLocalString: String {
            LocalStrings.Debt.PenaltyType.DynamicType.amount
        }
        static var percentLocalString: String {
            LocalStrings.Debt.PenaltyType.DynamicType.percent
        }
        static func dynamicTypeCDLocalize (type: String) -> String  {
            return type == PenaltyType.DynamicType.amount.rawValue ? amountLocalString : percentLocalString
        }
        
        enum DynamicPeriod: String, CaseIterable {
            case perDay
            case perWeek
//            case perMonth
            
            static var perDayLocalString: String {
                LocalStrings.Debt.PenaltyType.DynamicType.Period.perDay
            }
            static var perWeekLocalString: String {
                LocalStrings.Debt.PenaltyType.DynamicType.Period.perWeek
            }
//            static var perMonthLocalString: String {
//                LocalStrings.Period.perMonth
//            }
            static func dynamicPeriodCDLocalize (period: String) -> String  {
                
                var periodLocalize: String = ""
                
                switch period {
                case DynamicPeriod.perDay.rawValue: periodLocalize = DynamicPeriod.perDayLocalString
                case DynamicPeriod.perWeek.rawValue: periodLocalize = DynamicPeriod.perWeekLocalString
//                case DynamicPeriod.perMonth.rawValue: periodLocalize = DynamicPeriod.perMonthLocalString
                default: periodLocalize = DynamicPeriod.perDayLocalString
                }
                
                return periodLocalize
            }
        }
        
        enum PercentChargeType: String, CaseIterable {
            case initialDebt, balance
            
            static var initialDebtLocalString: String {
                LocalStrings.Debt.PenaltyType.DynamicType.PercentChargeType.initialDebt
            }
            static var balanceLocalString: String {
                LocalStrings.Debt.PenaltyType.DynamicType.PercentChargeType.balance
            }
            static func percentChargeTypeCDLocalize (type: String) -> String  {
                return type == PenaltyType.DynamicType.PercentChargeType.initialDebt.rawValue ? initialDebtLocalString : balanceLocalString
            }
        }
        
        
    }
    
    
}
