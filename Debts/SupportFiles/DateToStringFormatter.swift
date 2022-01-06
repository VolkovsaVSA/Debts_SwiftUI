//
//  MyDateFormatter.swift
//  Debts
//
//  Created by Sergei Volkov on 22.04.2021.
//

import Foundation

struct DateToStringFormatter {
    static func convertDate(date: Date?, dateStyle: DateFormatter.Style, timeStyle: DateFormatter.Style) -> String {
        var period = ""
        if let start = date {
            period += DateFormatter.localizedString(from: start, dateStyle: dateStyle, timeStyle: timeStyle)
        } else {
            period += NSLocalizedString("n/a", comment: "")
        }
        return period
    }
}
