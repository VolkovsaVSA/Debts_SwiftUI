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
            VStack {
                Toggle("Send notifications", isOn: $settingsVM.sendNotifications.animation())
                    .listRowSeparator(.hidden)
                if settingsVM.sendNotifications {
                    Toggle("Send all notifications about the delay of debt at one time", isOn: $settingsVM.changeAllNotificationTime.animation())
                        .listRowSeparator(.hidden)
                    if settingsVM.changeAllNotificationTime {
                        DatePicker(
                            "Notification time",
                            selection: $settingsVM.allNotificationTime,
                            displayedComponents: [.hourAndMinute]
                        )
                        
                    }
                }
            }
            .modifier(CellModifire(frameMinHeight: 10, useShadow: false))
        }
    }
}
