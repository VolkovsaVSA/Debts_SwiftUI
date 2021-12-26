//
//  BlackList.swift
//  Debts
//
//  Created by Sergey Volkov on 22.10.2019.
//  Copyright © 2019 Sergey Volkov. All rights reserved.
//

import Foundation

class BlackList {
    var name: String
    var status: String
    var phone: String
    var strikes: Int
    var strikesDays: Int
    var comment: String
    var lastStrike: Date
    var visible: Bool
    var userImage: Data
    
    var dictionary: NSDictionary {
        let dictionary = NSDictionary(objects: [name, status, phone, strikes, strikesDays, comment, lastStrike, visible, userImage], forKeys: ["name" as NSCopying, "status" as NSCopying, "phone" as NSCopying, "strikes" as NSCopying, "strikesDays" as NSCopying, "comment" as NSCopying, "lastStrike" as NSCopying, "visible" as NSCopying, "userImage" as NSCopying])
        return dictionary
    }
    
    
    init(name: String, status: String, phone: String, strikes: Int, strikesDays: Int, comment: String, lastStrike: Date, visible: Bool, userImage: Data) {
        self.name = name
        self.status = status
        self.phone = phone
        self.strikes = strikes
        self.strikesDays = strikesDays
        self.comment = comment
        self.lastStrike = lastStrike
        self.visible = visible
        self.userImage = userImage
    }
    convenience init(dictionary: NSDictionary) {
        var name: String
        var status: String
        var phone: String
        var strikes: Int
        var strikesDays: Int
        var comment: String
        var lastStrike: Date
        var visible: Bool
        var userImage: Data
        
        if let nameInit = dictionary.object(forKey: "name") as? String { name = nameInit } else { name = "" }
        if let statusInit = dictionary.object(forKey: "status") as? String { status = statusInit } else { status = "" }
        if let phoneInit = dictionary.object(forKey: "phone") as? String { phone = phoneInit } else { phone = "" }
        if let strikesInit = dictionary.object(forKey: "strikes") as? Int { strikes = strikesInit } else {strikes = 0}
        if let strikesDaysInit = dictionary.object(forKey: "strikesDays") as? Int { strikesDays = strikesDaysInit } else { strikesDays = 0 }
        if let commentInit = dictionary.object(forKey: "comment") as? String { comment = commentInit } else {comment = "" }
        if let lastStrikeInit = dictionary.object(forKey: "lastStrike") as? Date {lastStrike = lastStrikeInit} else {lastStrike = Date()}
        if let visibleInit = dictionary.object(forKey: "visible") as? Bool {visible = visibleInit} else {visible = true}
        if let userImageInit = dictionary.object(forKey: "userImage") as? Data {
            userImage = userImageInit
        } else {
            userImage = Data()
        }
        
        self.init(name: name, status: status, phone: phone, strikes: strikes, strikesDays: strikesDays, comment: comment, lastStrike: lastStrike, visible: visible, userImage: userImage)
    }
    
}
