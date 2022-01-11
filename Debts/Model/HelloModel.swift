//
//  HelloModel.swift
//  Debts
//
//  Created by Sergei Volkov on 05.01.2022.
//

import Foundation
import SwiftUI

struct HelloModel: Identifiable {

    let id: Int
    let title: String
    let text: String
    let image: String?

    init(id: Int, title: String, text: String, image: String? = nil) {
        self.id = id
        self.title = title
        self.text = text
        self.image = image
    }
}
