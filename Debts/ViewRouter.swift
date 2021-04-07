//
//  ViewRouter.swift
//  Debts
//
//  Created by Sergei Volkov on 07.04.2021.
//

import Foundation

class ViewRouter: ObservableObject {
    @Published var currentPage: Page = PageData.debts
}
