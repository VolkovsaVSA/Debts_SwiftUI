//
//  MenuActionModel.swift
//  Debts
//
//  Created by Sergei Volkov on 14.04.2021.
//

import Foundation

struct MenuActionModel: Hashable {
    let title: String
    let systemIcon: String
    let action: ()->()
    
    static func == (lhs: MenuActionModel, rhs: MenuActionModel) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(title);
        hasher.combine(systemIcon)
    }
}
