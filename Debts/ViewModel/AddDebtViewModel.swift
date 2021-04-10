//
//  AddDebtViewModel.swift
//  Debts
//
//  Created by Sergei Volkov on 10.04.2021.
//

import Foundation

class AddDebtViewModel: ObservableObject {
    @Published var debtAmount = ""
    @Published var firstName = ""
    @Published var familyName = ""
    @Published var phone = ""
    @Published var email = ""
    @Published var pickeBool = false
    @Published var localDebtorStatus = 0
    @Published var startDate = Date()
    @Published var endDate = Date()
    @Published var percent = ""
    @Published var comment = ""
    
    @Published var selectedPercentType: PercentType = .perYear
}
