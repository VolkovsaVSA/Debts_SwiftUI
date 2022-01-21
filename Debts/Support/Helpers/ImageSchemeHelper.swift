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
            switch localLang {
                case "ru": lang = localLang
                case "es": lang = localLang
                case "pt": lang = localLang
                case "fr": lang = localLang
                case "de": lang = localLang
                case "it": lang = localLang
                case "zh": lang = localLang
                case "ja": lang = localLang
                case "cs": lang = localLang
                default: lang = "en"
            }
            print(localLang)
          
        }
        return selectSuffixForScheme(colorScheme: colorScheme) + "_" + lang
    }
}
