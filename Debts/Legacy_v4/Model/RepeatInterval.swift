//
//  RepeatNotification.swift
//  Debts
//
//  Created by Sergey Volkov on 25.04.2020.
//  Copyright © 2020 Sergey Volkov. All rights reserved.
//

import Foundation

enum RepeatInterval: Int, CaseIterable, Codable {
    case everyMonth
    case everyWeek
    case everyDay
}
