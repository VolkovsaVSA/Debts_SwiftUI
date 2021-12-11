//
//  NotifManager.swift
//  Debts
//
//  Created by Sergei Volkov on 02.07.2021.
//

import Foundation
import UserNotifications

struct NotificationManager {
    static private let center = UNUserNotificationCenter.current()
    
    static func requestAuthorization(completion: @escaping  (Bool) -> Void) {
        center.requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            completion(success)
        }
    }
    
    static func removeAllPendingNotifications() {
        center.removeAllPendingNotificationRequests()
    }
    static func removeNotifications(identifiers: [String]) {
        center.removePendingNotificationRequests(withIdentifiers: identifiers)
    }
    
    static func sendNotificationOfEndDebt(debt: DebtCD) {
        
        guard let endDate = debt.endDate, let id = debt.id else {return}
        
        let content = UNMutableNotificationContent()
        content.title = String(localized: "Debt is overdue!")
        
        let fullName = debt.debtor?.fullName ?? ""
        let initialAmount = CurrencyViewModel.shared.currencyConvert(amount: debt.initialDebt as Decimal,
                                                                     currencyCode: debt.currencyCode)
        var body = ""
        
        if debt.debtorStatus == "debtor" {
            body = String(localized: "\(fullName) had to give you back \(initialAmount) no later than \(debt.localizeEndDateShort)")
        } else {
            body = String(localized: "You should have repaid the \(initialAmount) debt to \(fullName) no later than \(debt.localizeEndDateShort)")
        }
        
        if Double(truncating: debt.percent).round(to: 2) > 0 {
            let interest = CurrencyViewModel.shared.currencyConvert(amount: debt.calculatePercentAmountFunc(balanceType: Int(debt.percentBalanceType), calcPercent: debt.percent as Decimal, calcPercentType: Int(debt.percentType)), currencyCode: debt.currencyCode)
            
            body = String(localized: "\(body) and interest on the debt to date in the amount of \(interest)")
        }
        
        content.body = body
        content.sound = UNNotificationSound.default
        
        let calendar = Calendar.current
        var dateComponents = DateComponents(calendar: calendar,
                                            timeZone: TimeZone.current,
                                            year: calendar.component(.year, from: endDate),
                                            month: calendar.component(.month, from: endDate),
                                            day: calendar.component(.day, from: endDate),
                                            hour: calendar.component(.hour, from: endDate),
                                            minute: calendar.component(.minute, from: endDate))
        
        if UserDefaults.standard.bool(forKey: UDKeys.changeAllNotificationTime) {
            if let udDate = UserDefaults.standard.object(forKey: UDKeys.allNotificationTime) as? Date {
                dateComponents.hour = calendar.component(.hour, from: udDate)
                dateComponents.minute = calendar.component(.minute, from: udDate)
            }
        }
        
        let calendarTrigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        let request = UNNotificationRequest(identifier: id.uuidString, content: content, trigger: calendarTrigger)
        center.add(request, withCompletionHandler: nil)
        
    }
    
    
}
