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
        Section(header: Text("Notifications").fontWeight(.semibold).foregroundColor(.primary)) {
            SettingsToggleCell(title: LocalizedStringKey("Send notifications"),
                               systemImage: "app.badge",
                               isOn: $settingsVM.sendNotifications,
                               backgroundColor: .red)
            if settingsVM.sendNotifications {
                SettingsToggleCell(title: LocalizedStringKey("All at the same time"),
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
                            Text("Notification time")
                        }
                    }
                }
            }
//            .listRowSeparator(.hidden)
        }
    }
}
