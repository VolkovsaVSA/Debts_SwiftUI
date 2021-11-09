//
//  PersonImage.swift
//  Debts
//
//  Created by Sergei Volkov on 17.04.2021.
//

import SwiftUI

struct PersonImage: View {
    
//    var systemName = "person.crop.circle.fill"
    var size: CGFloat = 70
    
    var body: some View {
        Image(systemName: "person.crop.circle.fill")
            .resizable()
            .scaledToFit()
            .frame(width: size, height: size, alignment: .center)
            .foregroundColor(Color(UIColor.systemGray))
            .background(Color(UIColor.white))
            .clipShape(Circle())
    }
}

