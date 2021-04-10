//
//  CurrencyCell.swift
//  Debts
//
//  Created by Sergei Volkov on 10.04.2021.
//

import SwiftUI

struct CurrencyCell: View {
    
    let item: LocID
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Text(item.currencyCode)
                Text("-")
                Text(item.currencySymbol)
            }
            Text(item.localazedString)
                .font(.system(size: 14, weight: .light, design: .default))
        }
    }
}
