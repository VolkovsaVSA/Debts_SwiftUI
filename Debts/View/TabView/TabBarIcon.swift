//
//  TabBarIcon.swift
//  Debts
//
//  Created by Sergei Volkov on 06.04.2021.
//

import SwiftUI

struct TabBarIcon: View {
    
    @StateObject var viewRouter: ViewRouter
    
    let geometry: GeometryProxy
    let page: Page
    
    var body: some View {
        VStack {
            Image(systemName: page.sytemIcon)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: geometry.size.width/5, height: geometry.size.height/28)
            Text(page.title)
                .font(.footnote)
        }
        .padding(.horizontal, -6)
        .foregroundColor(viewRouter.currentPage == page ? Color.blue : Color.gray)
        .onTapGesture {
            viewRouter.currentPage = page
        }
    }
}

