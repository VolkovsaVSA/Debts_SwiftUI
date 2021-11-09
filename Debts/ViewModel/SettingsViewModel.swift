//
//  SettingsViewModel.swift
//  Debts
//
//  Created by Sergei Volkov on 19.04.2021.
//

import Foundation
import SwiftUI

class SettingsViewModel: ObservableObject {
    static let shared = SettingsViewModel()
    
    @Published var alert: AlertType?
    @Published var sheet: SheetType?
    
    @Published var showAdditionalInfo = true
    @Published var totalAmountWithInterest = true
    @Published var sendNotifications: Bool {
        didSet {
            if sendNotifications {
                NotificationManager.requestAuthorization { granted in
                    if granted {
                        CDStack.shared.fetchDebts(isClosed: false).forEach { debt in
                            NotificationManager.sendNotificationOfEndDebt(debt: debt)
                        }
                    } else {
                        DispatchQueue.main.async {
                            withAnimation {
                                self.sendNotifications = false
                            }
                            self.alert = .twoButtonActionCancel
                        }
                    }
                    UserDefaults.standard.set(granted, forKey: UDKeys.sendNotifications)
                }
            } else {
                UserDefaults.standard.set(sendNotifications, forKey: UDKeys.sendNotifications)
                changeAllNotificationTime = false
//
//                let debtsIds = CDStack.shared.fetchDebts().compactMap {dbt in dbt.id?.uuidString }
//                NotifManager.removeNotifications(identifiers: debtsIds)
//
                NotificationManager.removeAllPendingNotifications()
            }
        }
    }
    @Published var changeAllNotificationTime: Bool {
        didSet {
            UserDefaults.standard.set(changeAllNotificationTime, forKey: UDKeys.changeAllNotificationTime)
        }
    }
    @Published var allNotificationTime: Date {
        didSet {
            UserDefaults.standard.set(allNotificationTime, forKey: UDKeys.allNotificationTime)
        }
    }
    
    init() {
        sendNotifications = UserDefaults.standard.bool(forKey: UDKeys.sendNotifications)
        changeAllNotificationTime = UserDefaults.standard.bool(forKey: UDKeys.changeAllNotificationTime)
        
        if let date = UserDefaults.standard.object(forKey: UDKeys.allNotificationTime) as? Date {
            allNotificationTime = date
        } else {
            let calendar = Calendar.current
            var dateComponents = DateComponents()
            dateComponents.timeZone = TimeZone.current
            dateComponents.hour = 12
            dateComponents.minute = 00
            allNotificationTime = calendar.date(from: dateComponents)!
        }
        
    }
}
