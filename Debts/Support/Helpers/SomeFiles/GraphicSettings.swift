//
//  GraphicSettings.swift
//  Debts
//
//  Created by Sergei Volkov on 06.05.2021.
//

import SwiftUI

struct GraphicSettings {
    static func calcRotateWidth(geometry: GeometryProxy) -> CGFloat {
        return geometry.size.height > geometry.size.width ? geometry.size.width : geometry.size.height
    }
}
