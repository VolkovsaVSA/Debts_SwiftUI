//
//  CustomSheetModifire.swift
//  Debts
//
//  Created by Sergei Volkov on 01.12.2021.
//

import SwiftUI

struct CustomActionSheetModifire: ViewModifier {
    
    private let sheetCornerRadius: CGFloat = 25
    
    let width: CGFloat
    let isShow: Bool

    func body(content: Content) -> some View {
        content
            .frame(width: width)
            .padding(.vertical, sheetCornerRadius/1.5)
            .padding(.bottom, 60)
            .background(Color.init(UIColor.secondarySystemBackground))
            .cornerRadius(sheetCornerRadius)
            .offset(y: isShow ? sheetCornerRadius : width)
    }
}
