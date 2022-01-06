//
//  MyDateFormatter.swift
//  Debts
//
//  Created by Sergey Volkov on 09.11.2019.
//  Copyright © 2019 Sergey Volkov. All rights reserved.
//

import Foundation

struct OldMyDateFormatter {
    static func shortDate()->DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        return dateFormatter
    }
    static func mediumDateNoTime()->DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        return dateFormatter
    }
    static func fullDateAndTime()->DateFormatter {
        let dateFormatterFull = DateFormatter()
        dateFormatterFull.dateStyle = .full
        dateFormatterFull.timeStyle = .full
        return dateFormatterFull
    }
    static func fullDateNoTime()->DateFormatter {
        let dateFormatterFull = DateFormatter()
        dateFormatterFull.dateStyle = .full
        dateFormatterFull.timeStyle = .none
        return dateFormatterFull
    }
}
