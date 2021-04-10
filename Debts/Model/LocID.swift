//
//  LocID.swift
//  Debts
//
//  Created by Sergey Volkov on 01.10.2020.
//  Copyright © 2020 Sergey Volkov. All rights reserved.
//

import Foundation

struct LocID: Equatable, Hashable {
    static func == (lhs: LocID, rhs: LocID) -> Bool {
        return (lhs.currencyCode == rhs.currencyCode)
    }
    var currencyCode: String
    var currencySymbol: String
    var localazedString: String
    
//    var dictionary: NSDictionary {
//        let tempDictionary = NSDictionary(objects: [currencyCode, currencySymbol, localazedString], forKeys: ["currencyCode" as NSCopying, "currencySymbol" as NSCopying, "localazedString" as NSCopying])
//        return tempDictionary
//    }
//
//    init(currencyCode: String, currencySymbol: String, localazedString: String) {
//        self.currencyCode = currencyCode
//        self.currencySymbol = currencySymbol
//        self.localazedString = localazedString
//    }
//    convenience init(dictionary: NSDictionary) {
//        var currencyCode: String
//        var currencySymbol: String
//        var localazedString: String
//
//        if let currencyCodeInit = dictionary.object(forKey: "currencyCode") as? String {currencyCode = currencyCodeInit} else {currencyCode = "USD"}
//        if let currencySymbolInit = dictionary.object(forKey: "currencySymbol") as? String {currencySymbol = currencySymbolInit} else {currencySymbol = "$"}
//        if let localazedStringInit = dictionary.object(forKey: "localazedString") as? String {localazedString = localazedStringInit} else {localazedString = "n/a"}
//
//        self.init(currencyCode: currencyCode, currencySymbol: currencySymbol, localazedString: localazedString)
//    }
}
