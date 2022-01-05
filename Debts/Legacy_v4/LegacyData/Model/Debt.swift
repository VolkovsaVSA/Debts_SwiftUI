//
//  Debt.swift
//  Debts
//
//  Created by Sergey Volkov on 22.10.2019.
//  Copyright © 2019 Sergey Volkov. All rights reserved.
//

import Foundation

class Debt: Codable {

    var name: String
    var summ: Double
    var date: Date
    var status: String
    var comment: String
    var startDate: Date
    var percent: Double
    var phone: String
    var email: String
    var item1: String //percent type
    var item2: String //repay date
    var item3: String //fixed percent after repay
    var item4: String //initial amount
    var localID: String //currencyCode
    //for history
    var endPayDate: Date
    var endPercentSumm: Double
    var userImage: Data
    //for repayment
    var notificationID: String
    var notificationTitle: String
    var notificationBody: String
    var notificationDate: Date
    var notificationRepeat: Bool
    var notificationInterval: RepeatInterval
    var notificationAmountRepayment: Double
    
    var dictionary : NSDictionary {
        let dictionary = NSDictionary(objects: [name, summ, date, status, comment, startDate, percent, phone, email, item1, item2, item3, item4, localID, endPayDate, endPercentSumm, userImage, notificationID, notificationTitle, notificationBody, notificationDate, notificationRepeat, notificationInterval.rawValue, notificationAmountRepayment], forKeys:
            ["name" as NSCopying, "summ" as NSCopying, "date" as NSCopying,"status" as NSCopying,"comment" as NSCopying,"startDate" as NSCopying,"percent" as NSCopying,"phone" as NSCopying,"emal" as NSCopying,"item1" as NSCopying,"item2" as NSCopying,"item3" as NSCopying,"item4" as NSCopying,"localID" as NSCopying,"endPayDate" as NSCopying,"endPercentSumm" as NSCopying,"userImage" as NSCopying,"notificationID" as NSCopying,"notificationTitle" as NSCopying,"notificationBody" as NSCopying,"notificationDate" as NSCopying,"notificationRepeat" as NSCopying,"notificationInterval" as NSCopying,"notificationAmountRepayment" as NSCopying])
        
        return dictionary
    }
    
    init(name: String, summ: Double, date: Date, status: String, comment: String, startDate: Date, percent: Double, phone: String, email: String, item1: String, item2: String, item3: String, item4: String, localID: String, endPayDate: Date, endPercentSumm: Double, userImage: Data, notificationID: String, notificationTitle: String, notificationBody: String, notificationDate: Date, notificationRepeat: Bool, notificationInterval: RepeatInterval, notificationAmountRepayment: Double) {
        self.name = name
        self.summ = summ
        self.date = date
        self.status = status
        self.comment = comment
        self.startDate = startDate
        self.percent = percent
        self.phone = phone
        self.email = email
        self.item1 = item1
        self.item2 = item2
        self.item3 = item3
        self.item4 = item4
        self.localID = localID
        self.endPayDate = endPayDate
        self.endPercentSumm = endPercentSumm
        self.userImage = userImage
        self.notificationID = notificationID
        self.notificationTitle = notificationTitle
        self.notificationBody = notificationBody
        self.notificationDate = notificationDate
        self.notificationRepeat = notificationRepeat
        self.notificationInterval = notificationInterval
        self.notificationAmountRepayment = notificationAmountRepayment
    }
    convenience init(dictionary: NSDictionary) {
        var name: String
        var summ: Double
        var date: Date
        var status: String
        var comment: String
        var startDate: Date
        var percent: Double
        var phone: String
        var email: String
        var item1: String //percent type
        var item2: String //repay date
        var item3: String //fixed percent after repay
        var item4: String //initial amount
        var localID: String
        let endPayDate: Date
        let endPercentSumm: Double
        var userImage: Data
        
        var notificationID: String
        var notificationTitle: String
        var notificationBody: String
        var notificationDate: Date
        var notificationRepeat: Bool
        var notificationInterval: RepeatInterval
        var notificationAmountRepayment: Double
        
        if let nameInit = dictionary.object(forKey: "name") as? String {name = nameInit} else {name = ""}
        if let summInit = dictionary.object(forKey: "summ") as? Double {summ = summInit} else {summ = 0}
        if let dateInit = dictionary.object(forKey: "date") as? Date {date = dateInit} else {date = Date()}
        if let statusInit = dictionary.object(forKey: "status") as? String {status = statusInit} else {status = ""}
        if let commentInit = dictionary.object(forKey: "comment") as? String {comment = commentInit} else {comment = ""}
        if let startDateInit = dictionary.object(forKey: "startDate") as? Date {startDate = startDateInit} else {startDate = Date()}
        if let percentInit = dictionary.object(forKey: "percent") as? Double {percent = percentInit} else {percent = 0}
        if let phoneInit = dictionary.object(forKey: "phone") as? String {phone = phoneInit} else {phone = ""}
        if let emailInit = dictionary.object(forKey: "email") as? String {email = emailInit} else {email = ""}
        if let item1Init = dictionary.object(forKey: "item1") as? String {item1 = item1Init} else {item1 = ""}
        if let item2Init = dictionary.object(forKey: "item2") as? String {item2 = item2Init} else {item2 = ""}
        if let item3Init = dictionary.object(forKey: "item3") as? String {item3 = item3Init} else {item3 = ""}
        if let item4Init = dictionary.object(forKey: "item4") as? String {item4 = item4Init} else {item4 = ""}
        if let localIDInit = dictionary.object(forKey: "localID") as? String {localID = localIDInit} else {localID = Currency.CurrentLocal.currencyCode}
        if let endPayDateInit = dictionary.object(forKey: "endPayDate") as? Date {
            endPayDate = endPayDateInit
        } else {
            endPayDate = Date()
        }
        if let endPercentSummInit = dictionary.object(forKey: "endPercentSumm") as? Double {
            endPercentSumm = endPercentSummInit
        } else {
            endPercentSumm = 0
        }
        
        if let userImageInit = dictionary.object(forKey: "userImage") as? Data {
            userImage = userImageInit
        } else {
            userImage = Data()
        }
        
        if let notificationIDInit = dictionary.object(forKey: "notificationID") as? String {notificationID = notificationIDInit} else {notificationID = ""}
        if let notificationTitleInit = dictionary.object(forKey: "notificationTitle") as? String {notificationTitle = notificationTitleInit} else {notificationTitle = ""}
        if let notificationBodyInit = dictionary.object(forKey: "notificationBody") as? String {notificationBody = notificationBodyInit} else {notificationBody = ""}
        if let notificationDateInit = dictionary.object(forKey: "notificationDate") as? Date {notificationDate = notificationDateInit} else {notificationDate = Date()}
        if let notificationRepeatInit = dictionary.object(forKey: "notificationRepeat") as? Bool {notificationRepeat = notificationRepeatInit} else {notificationRepeat = false}
        if let notificationIntervalInit = dictionary.object(forKey: "notificationInterval") as? Int {notificationInterval = RepeatInterval(rawValue: notificationIntervalInit)!} else {notificationInterval = RepeatInterval(rawValue: 0)!}
        if let notificationAmountRepaymentInit = dictionary.object(forKey: "notificationAmountRepayment") as? Double {
            notificationAmountRepayment = notificationAmountRepaymentInit
        } else {
            notificationAmountRepayment = 0
        }
        
        self.init(name: name, summ: summ, date: date, status: status, comment: comment, startDate: startDate, percent: percent, phone: phone, email: email, item1: item1, item2: item2, item3: item3, item4: item4, localID: localID, endPayDate: endPayDate, endPercentSumm: endPercentSumm, userImage: userImage, notificationID: notificationID, notificationTitle: notificationTitle, notificationBody: notificationBody, notificationDate: notificationDate, notificationRepeat: notificationRepeat, notificationInterval: notificationInterval, notificationAmountRepayment: notificationAmountRepayment)
    }
}
