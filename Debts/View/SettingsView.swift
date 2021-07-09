//
//  SettingsView.swift
//  Debts
//
//  Created by Sergei Volkov on 14.04.2021.
//

import SwiftUI

struct SettingsView: View {
    
    @EnvironmentObject var currencyVM: CurrencyViewModel
    @EnvironmentObject var settingsVM: SettingsViewModel
    
    var body: some View {
        
        NavigationView {
            
            List {
                Toggle("Show currency code", isOn: $currencyVM.showCurrencyCode)
                    .listRowSeparator(.hidden)
                Toggle("Show additional info", isOn: $settingsVM.showAdditionalInfo)
                    .listRowSeparator(.hidden)
                Toggle("The total amount of debt with accrued interest", isOn: $settingsVM.totalAmountWithInterest)
                
                Section(header: Text("Notifications")) {
                    
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
    //                            .datePickerStyle(GraphicalDatePickerStyle())
                        }
                    }
                    
                }
                
            }
            .listRowSeparator(.hidden)
            .navigationTitle(LocalizedStringKey("Settings"))
            
        }
        
        .alert(item: $settingsVM.alertType) { alert in
            switch alert {
            case .twoButtonActionCancel:
                return Alert(title: Text("Attention!"),
                             message: Text("Previously, you turned off notifications for this app. Do you want to enable notifications in system settings?"),
                             primaryButton: .default(Text("OK"),
                                                     action: {
                    if let settingsUrl = URL(string: UIApplication.openSettingsURLString) {
                        UIApplication.shared.open(settingsUrl)
                    }
                }),
                             secondaryButton: .cancel(Text("Cancel"), action: {
                    
                }))
            default:
                return Alert(title: Text(""))
            }
        }
        
    }
}
