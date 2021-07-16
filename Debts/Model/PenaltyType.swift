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
        String(localized: "Fixed")
    }
    static var dynamicLocalString: String {
        String(localized: "Dynamic")
    }
    static func penaltyTypeCDLocalize (type: String) -> String  {
        return type == PenaltyType.fixed.rawValue ? fixedLocalString : dynamicLocalString
    }
    
    enum DynamicType: String, CaseIterable {
        case amount, percent
        
        static var amountLocalString: String {
            String(localized: "Amount")
        }
        static var percentLocalString: String {
            String(localized: "Percent")
        }
        static func dynamicTypeCDLocalize (type: String) -> String  {
            return type == PenaltyType.DynamicType.amount.rawValue ? amountLocalString : percentLocalString
        }
        
        enum DynamicPeriod: String, CaseIterable {
            case perDay, perWeek, perMonth
            
            static var perDayLocalString: String {
                LocalStrings.Period.perDay
            }
            static var perWeekLocalString: String {
                LocalStrings.Period.perWeek
            }
            static var perMonthLocalString: String {
                LocalStrings.Period.perMonth
            }
            static func dynamicPeriodCDLocalize (period: String) -> String  {
                
                var periodLocalize: String = ""
                
                switch period {
                case DynamicPeriod.perDay.rawValue: periodLocalize = DynamicPeriod.perDayLocalString
                case DynamicPeriod.perWeek.rawValue: periodLocalize = DynamicPeriod.perWeekLocalString
                case DynamicPeriod.perMonth.rawValue: periodLocalize = DynamicPeriod.perMonthLocalString
                default: periodLocalize = DynamicPeriod.perDayLocalString
                }
                
                return periodLocalize
            }
        }
        
        enum PercentChargeType: String, CaseIterable {
            case initialDebt, balance
            
            static var initialDebtLocalString: String {
                String(localized: "Initial debt")
            }
            static var balanceLocalString: String {
                String(localized: "Balance")
            }
            static func percentChargeTypeCDLocalize (type: String) -> String  {
                return type == PenaltyType.DynamicType.PercentChargeType.initialDebt.rawValue ? initialDebtLocalString : balanceLocalString
            }
        }
        
        
    }
    
    
}
