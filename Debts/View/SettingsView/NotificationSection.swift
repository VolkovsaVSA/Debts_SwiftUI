//
//  NotificationSection.swift
//  Debts
//
//  Created by Sergei Volkov on 13.12.2021.
//

import SwiftUI

struct NotificationSection: View {
    
    @EnvironmentObject private var currencyVM: CurrencyViewModel
    @EnvironmentObject private var settingsVM: SettingsViewModel
    
    var body: some View {
        Section(header: Text(LocalStrings.Views.Settings.notifications).fontWeight(.semibold).foregroundColor(.primary)) {
            SettingsToggleCell(title: LocalStrings.Views.Settings.sendNotifications,
                               systemImage: "app.badge",
                               isOn: $settingsVM.sendNotifications,
                               backgroundColor: .red)
            if settingsVM.sendNotifications {
                SettingsToggleCell(title: LocalStrings.Views.Settings.allAtTheSameTime,
                                   systemImage: "calendar.badge.clock",
                                   isOn: $settingsVM.changeAllNotificationTime,
                                   backgroundColor: .blue)
                if settingsVM.changeAllNotificationTime {
                    
                    HStack(alignment: .center, spacing: 6) {
                        Image(systemName: "clock")
                            .foregroundColor(.white)
                            .frame(width: 28, height: 28)
                            .background(
                                RoundedRectangle(cornerRadius: 6, style: .circular)
                                    .fill(Color.green)
                            )
                        DatePicker(selection: $settingsVM.allNotificationTime, displayedComponents: [.hourAndMinute]) {
                            Text(LocalStrings.Views.Settings.notificationTime)
                        }
                    }
                }
            }
//            .listRowSeparator(.hidden)
        }
    }
}
