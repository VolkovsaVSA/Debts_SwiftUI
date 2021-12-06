//
//  EditDebtorDataViewModel.swift
//  Debts
//
//  Created by Sergei Volkov on 06.12.2021.
//

import Foundation
import UIKit

class EditDebtorDataViewModel: ObservableObject {
    static let shared = EditDebtorDataViewModel()
    
    @Published var image: UIImage?
    @Published var refreshID = UUID()
}
