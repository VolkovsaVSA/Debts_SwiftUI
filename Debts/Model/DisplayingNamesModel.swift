//
//  DisplayingNamesModel.swift
//  Debts
//
//  Created by Sergei Volkov on 04.01.2022.
//

import SwiftUI

enum DisplayingNamesModel: String, CaseIterable {
    case first, family
    
    private static var firstLocalString: LocalizedStringKey {
        LocalizedStringKey("first + family")
    }
    private static var familyLocalString: LocalizedStringKey {
        LocalizedStringKey("family + first")
    }
    static func localize(inputCase: Self) -> LocalizedStringKey  {
        var displayingNamesLocal: LocalizedStringKey = ""
        switch inputCase {
            case .first: displayingNamesLocal = firstLocalString
            case .family: displayingNamesLocal = familyLocalString
        }
        return displayingNamesLocal
    }
}
