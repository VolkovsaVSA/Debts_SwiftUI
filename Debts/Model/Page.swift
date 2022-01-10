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

enum PageCase: Hashable {
    case debts, debtors, history, settings
}

struct PageData {
    static let debts = Page(title: LocalStrings.Views.Pages.debts,
                            sytemIcon: "book",
                            pageCase: .debts)
    static let debtors = Page(title: LocalStrings.Views.Pages.debtors,
                              sytemIcon: "person.crop.circle",
                              pageCase: .debtors)
    static let history = Page(title: LocalStrings.Views.Pages.history,
                              sytemIcon: "books.vertical",
                              pageCase: .history)
    static let settings = Page(title: LocalStrings.Views.Pages.settings,
                               sytemIcon: "gear",
                               pageCase: .settings)
}
