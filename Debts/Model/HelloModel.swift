//
//  HelloModel.swift
//  Debts
//
//  Created by Sergei Volkov on 05.01.2022.
//

import Foundation
import SwiftUI

struct HelloModel: Identifiable {
//    static func == (lhs: HelloModel, rhs: HelloModel) -> Bool {
//        return lhs.id == rhs.id
//    }
    
    let id: Int
    let title: String
    let text: String
    let image: String?
    let systemImage: String?
    
    init(id: Int, title: String, text: String, image: String? = nil, systemImage: String? = nil) {
        self.id = id
        self.title = title
        self.text = text
        self.image = image
        self.systemImage = systemImage
    }
}
