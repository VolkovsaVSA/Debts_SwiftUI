//
//  DebtDetailCellModifire.swift
//  Debts
//
//  Created by Sergei Volkov on 05.12.2021.
//

import SwiftUI

struct DebtDetailCellModifire: ViewModifier {
    
    @Environment(\.colorScheme) private var colorScheme
    
    func body(content: Content) -> some View {
        content
            .listRowSeparator(.hidden)
    }
}

