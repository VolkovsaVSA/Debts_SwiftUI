//
//  DebtMigrationModel.swift
//  Debts
//
//  Created by Sergei Volkov on 27.12.2021.
//

import Foundation

struct DebtMigrationModel: Hashable {
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
}
