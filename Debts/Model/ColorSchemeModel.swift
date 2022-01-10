//
//  ColorSchemeModel.swift
//  Debts
//
//  Created by Sergei Volkov on 22.12.2021.
//

import Foundation
import SwiftUI

enum ColorSchemeModel: String, CaseIterable {

    case light, dark, system
    
    private static var lightLocalString: String {
        LocalStrings.Settings.ColorScheme.light
    }
    private static var darkLocalString: String {
        LocalStrings.Settings.ColorScheme.dark
    }
    private static var systemLocalString: String {
        LocalStrings.Settings.ColorScheme.system
    }

    static func localize(inputCase: Self) -> String  {
        var statusString: String = ""
        switch inputCase {
            case .light: statusString = lightLocalString
            case .dark: statusString = darkLocalString
            case .system: statusString = systemLocalString
        }
        return statusString
    }

}
