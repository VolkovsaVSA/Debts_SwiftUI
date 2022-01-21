//
//  AppGroup.swift
//  Debts
//
//  Created by Sergey Volkov on 29.09.2020.
//  Copyright © 2020 Sergey Volkov. All rights reserved.
//

import Foundation

public struct AppGroup {
    static let debts = "group.VSA.Debts"
    
    struct MyDefaults {
//        static let dataKey = "dataKey"
        static let showCurrencySegmentKey = "ShowCurrencySegment"
        
        static func save(value: Any, key: String) {
            if let groupUserDefaults = UserDefaults(suiteName: debts) {
                groupUserDefaults.set(value, forKey: key)
                print("save mydefaults")
            }
        }
        
        static func load(key: String) -> Any? {
            var object: Any?
            if let groupUserDefaults = UserDefaults(suiteName: debts) {
                object = groupUserDefaults.object(forKey: key)
                print("load mydefaults")
            }
            return object
        }
        
    }
    
}
