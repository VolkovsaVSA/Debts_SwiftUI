//
//  SortDebtorsModel.swift
//  Debts
//
//  Created by Sergei Volkov on 10.12.2021.
//

import Foundation

struct SortDebtorsModel: Hashable, Identifiable {
    var type: SortDebtorsType
    var isDecrease: Bool
    
    var id: Int {
        hashValue
    }
}

enum SortDebtorsType: Int {
    case firstName
    case familyName

    static func localizedSortType(_ item: SortDebtorsModel) -> String {
        let arrow = (item.isDecrease ? " \u{2191}" : " \u{2193}")
        switch item.type {
            case .firstName:
                return String(localized: "first name") + arrow
            case .familyName:
                return String(localized: "family name") + arrow
        }
    }
}

class SortDebtorsObject: ObservableObject {
    
    static let shared  = SortDebtorsObject()
    
    init() {
        let sortDebtorsType = SortDebtorsType(rawValue: UserDefaults.standard.integer(forKey: UDKeys.sortDebtorsType))
        let sortDebtorsDecrease = UserDefaults.standard.bool(forKey: UDKeys.sortDebtorsDecrease)
        let saveSelected = SortDebtorsModel(type: sortDebtorsType ?? .firstName, isDecrease: sortDebtorsDecrease)
        var tempArr =
        [
            SortDebtorsModel(type: .firstName, isDecrease: false),
            SortDebtorsModel(type: .familyName, isDecrease: false),
        ]
        
        for (index, value) in tempArr.enumerated() {
            if value.type == saveSelected.type {
                tempArr[index].isDecrease = saveSelected.isDecrease
            }
        }
        
        self.sortArray = tempArr
        selected = saveSelected
        self.sortDescriptors = sortDebtorsType == .firstName ?
        [
            NSSortDescriptor(keyPath: \DebtorCD.firstName, ascending: sortDebtorsDecrease),
            NSSortDescriptor(keyPath: \DebtorCD.familyName, ascending: sortDebtorsDecrease),
        ]
        :
        [
            NSSortDescriptor(keyPath: \DebtorCD.familyName, ascending: sortDebtorsDecrease),
            NSSortDescriptor(keyPath: \DebtorCD.firstName, ascending: sortDebtorsDecrease),]
        
        sortDebts()
    }


    @Published var sortDescriptors = [
        NSSortDescriptor(keyPath: \DebtorCD.firstName, ascending: true),
        NSSortDescriptor(keyPath: \DebtorCD.familyName, ascending: true),
    ]

    @Published var sortArray: [SortDebtorsModel]
    @Published var selected: SortDebtorsModel {
        didSet {
            if selected == oldValue {
                for (index, value) in sortArray.enumerated() {
                    if value == oldValue {
                        sortArray[index].isDecrease.toggle()
                        selected.isDecrease.toggle()
                    }
                }
            }
            sortDebts()
        }
    }
    @Published var refreshedID = UUID()
    
    var convertSortDescriptors: [SortDescriptor<DebtorCD>] {
        var result = [SortDescriptor<DebtorCD>]()
        sortDescriptors.forEach { descriptor in
            if let newDescriptor = SortDescriptor(descriptor, comparing: DebtorCD.self) {
                result.append(newDescriptor)
            }
        }
        return result
    }
    
    private func createSortDescriptors(reversed: Bool, isDecrease: Bool) -> [NSSortDescriptor] {
        return reversed ?
        [NSSortDescriptor(keyPath: \DebtorCD.familyName, ascending: !isDecrease),
         NSSortDescriptor(keyPath: \DebtorCD.firstName, ascending: !isDecrease),]
        :
        [NSSortDescriptor(keyPath: \DebtorCD.firstName, ascending: !isDecrease),
         NSSortDescriptor(keyPath: \DebtorCD.familyName, ascending: !isDecrease),]
    }
    
    private func sortDebts() {
        switch selected.type {
            case .firstName:
                sortDescriptors = createSortDescriptors(reversed: false, isDecrease: selected.isDecrease)
            case .familyName:
                sortDescriptors = createSortDescriptors(reversed: true, isDecrease: selected.isDecrease)
        }
        
//        refreshedID = UUID()
        
        DispatchQueue.main.async {
            UserDefaults.standard.set(self.selected.type.rawValue, forKey: UDKeys.sortDebtorsType)
            UserDefaults.standard.set(self.selected.isDecrease, forKey: UDKeys.sortDebtorsDecrease)
        }
    }
}
