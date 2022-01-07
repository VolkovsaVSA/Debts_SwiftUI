//
//  ImageSchemeHelper.swift
//  Debts
//
//  Created by Sergei Volkov on 06.01.2022.
//

import SwiftUI

struct ImageSchemeHelper {
    
    private enum Scheme: String {
        case _light, _dark
    }
    
    static func selectSuffixForScheme(colorScheme: ColorScheme) -> String {
        var localScheme = Scheme._light
        localScheme = colorScheme == .dark ? ._dark : colorScheme == .light ? ._light : ._dark
        return localScheme.rawValue
    }
    
    static func selectSuffixForLocale(colorScheme: ColorScheme) -> String {
        var lang = "en"
        if let localLang = Locale.current.languageCode {
            lang = localLang
        }
        return selectSuffixForScheme(colorScheme: colorScheme) + "_" + lang
    }
}
