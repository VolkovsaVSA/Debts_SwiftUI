//
//  DebtDatailHStackItem.swift
//  Debts
//
//  Created by Sergei Volkov on 27.05.2021.
//

import SwiftUI

struct DebtDetailHStackCell: View {
    
    let firstColumn: String
    var firstColumnDetail: String?
    let secondColumn: String
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 2) {
                Text(firstColumn)
                    .font(.system(size: 17, weight: .thin, design: .default))
                if let detailText = firstColumnDetail {
                    Text(detailText)
                        .font(.system(size: 12, weight: .thin, design: .default))
                }
            }
            
            Spacer()
            Text(secondColumn)
                .font(.system(size: 17, weight: .medium, design: .default))
        }
    }
}
