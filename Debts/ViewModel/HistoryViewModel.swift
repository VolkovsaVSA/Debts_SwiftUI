//
//  HistoryViewModel.swift
//  Debts
//
//  Created by Sergei Volkov on 05.11.2021.
//

import Foundation

class HistoryViewModel: ObservableObject {
    static let shared = HistoryViewModel()
    
    @Published var refreshedID = UUID()
}
