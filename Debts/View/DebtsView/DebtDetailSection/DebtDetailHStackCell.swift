//
//  DebtDatailHStackItem.swift
//  Debts
//
//  Created by Sergei Volkov on 27.05.2021.
//

import SwiftUI

struct DebtDetailHStackCell: View {
    
    let firstColumn: String
    let secondColumn: String
    
    var body: some View {
        HStack {
            Text(firstColumn)
                .font(.system(size: 17, weight: .thin, design: .default))
            Spacer()
            Text(secondColumn)
                .font(.system(size: 17, weight: .medium, design: .default))
        }
    }
}

struct DebtDatailHStackItem_Previews: PreviewProvider {
    static var previews: some View {
        DebtDetailHStackCell(firstColumn: "firstColumn", secondColumn: "secondColumn")
    }
}
