//
//  Page.swift
//  Debts
//
//  Created by Sergei Volkov on 07.04.2021.
//

import SwiftUI

struct Page: Equatable {
    let title: String
    let sytemIcon: String
    let pageCase: PageCase
}

enum PageCase {
    case debts, debtors, history, settings
}

struct PageData {
    static let debts = Page(title: NSLocalizedString("Debts", comment: "tabBarIconTitle"),
                            sytemIcon: "book",
                            pageCase: .debts)
    static let debtors = Page(title: NSLocalizedString("Debtors", comment: "tabBarIconTitle"),
                              sytemIcon: "person.crop.circle",
                              pageCase: .debtors)
    static let history = Page(title: NSLocalizedString("History", comment: "tabBarIconTitle"),
                              sytemIcon: "books.vertical",
                              pageCase: .history)
    static let settings = Page(title: NSLocalizedString("Settings", comment: "tabBarIconTitle"),
                               sytemIcon: "gear",
                               pageCase: .settings)
}
