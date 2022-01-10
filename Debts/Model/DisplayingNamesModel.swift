//
//  DisplayingNamesModel.swift
//  Debts
//
//  Created by Sergei Volkov on 04.01.2022.
//

import SwiftUI

enum DisplayingNamesModel: String, CaseIterable {
    case first, family
    
    private static var firstLocalString: String {
        LocalStrings.Settings.DisplayingNamesModel.first
    }
    private static var familyLocalString: String {
        LocalStrings.Settings.DisplayingNamesModel.family
    }
    static func localize(inputCase: Self) -> String  {
        var displayingNamesLocal: String = ""
        switch inputCase {
            case .first: displayingNamesLocal = firstLocalString
            case .family: displayingNamesLocal = familyLocalString
        }
        return displayingNamesLocal
    }
}
