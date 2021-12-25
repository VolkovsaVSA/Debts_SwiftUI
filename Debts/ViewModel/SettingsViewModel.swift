//
//  SettingsViewModel.swift
//  Debts
//
//  Created by Sergei Volkov on 19.04.2021.
//

import Foundation
import SwiftUI

final class SettingsViewModel: ObservableObject {
    static let shared = SettingsViewModel()
    
    @Published var biometry: BiometryType = .none
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
    @Published var authentication = false {
        didSet {
            UserDefaults.standard.set(authentication, forKey: UDKeys.authentication)
        }
    }
    @Published var preferedColorscheme: ColorSchemeModel = .system {
        didSet {
            UserDefaults.standard.set(preferedColorscheme.rawValue, forKey: UDKeys.colorScheme)
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
        
        if let auth = UserDefaults.standard.object(forKey: UDKeys.authentication) as? Bool {
            authentication = auth
        }
        
        preferedColorscheme = ColorSchemeModel(rawValue: UserDefaults.standard.string(forKey: UDKeys.colorScheme) ?? ColorSchemeModel.system.rawValue) ?? ColorSchemeModel.system
        
    }
}
