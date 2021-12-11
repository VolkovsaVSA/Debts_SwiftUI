//
//  NoDataBanner.swift
//  Debts
//
//  Created by Sergei Volkov on 05.12.2021.
//

import SwiftUI

struct NoDataBanner: View {
    
    let text: LocalizedStringKey
    
    var body: some View {
        VStack {
            Spacer()
            Text(text).font(.title)
                .padding()
                .background(.thinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 12))
            Spacer()
        }
    }
}
