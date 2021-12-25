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
    
    private static var lightLocalString: LocalizedStringKey {
        LocalizedStringKey("Light")
    }
    private static var darkLocalString: LocalizedStringKey {
        LocalizedStringKey("Dark")
    }
    private static var systemLocalString: LocalizedStringKey {
        LocalizedStringKey("System")
    }

    static func colorSchemeLocalize (status: ColorSchemeModel) -> LocalizedStringKey  {
        var statusString: LocalizedStringKey = ""
        switch status {
            case .light: statusString = lightLocalString
            case .dark: statusString = darkLocalString
            case .system: statusString = systemLocalString
        }
        return statusString
    }

}
