//
//  SortModel.swift
//  Debts
//
//  Created by Sergei Volkov on 08.11.2021.
//

import Foundation

struct DebtSortModel: Hashable, Identifiable {
    var type: DebtSortType
    var isDecrease: Bool
    
    var id: Int {
        hashValue
    }
}

enum DebtSortType: Int {
    case name
    case debt
    case startDate
    case endDate
    
    static func localizedSortType(_ item: DebtSortModel) -> String {
        let arrow = (item.isDecrease ? " \u{2191}" : " \u{2193}")
        switch item.type {
            case .name:
                return LocalStrings.Debtor.Attributes.name + arrow
            case .debt:
                return LocalStrings.Debt.Attributes.debt + arrow
            case .startDate:
                return LocalStrings.Debt.Attributes.startDate + arrow
            case .endDate:
                return LocalStrings.Debt.Attributes.endDate + arrow
        }
    }
}

class SortObject: ObservableObject {
    
    init() {
        let sortType = DebtSortType(rawValue: UserDefaults.standard.integer(forKey: UDKeys.sortType))
        let sortDecrease = UserDefaults.standard.bool(forKey: UDKeys.sortDecrease)
        let saveSelected = DebtSortModel(type: sortType ?? .startDate, isDecrease: sortDecrease)
        var tempArr =
        [
            DebtSortModel(type: .name, isDecrease: false),
            DebtSortModel(type: .debt, isDecrease: false),
            DebtSortModel(type: .startDate, isDecrease: false),
            DebtSortModel(type: .endDate, isDecrease: false),
        ]
        
        for (index, value) in tempArr.enumerated() {
            if value.type == saveSelected.type {
                tempArr[index].isDecrease = saveSelected.isDecrease
            }
        }
        
        self.sortArray = tempArr
        selected = saveSelected
        sortDebts()
    }

    @Published var sortArray: [DebtSortModel]
    @Published var selected: DebtSortModel {
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
    
    private func sortDebts() {
        switch selected.type {
            case .name:
                selected.isDecrease ?
                DebtsViewModel.shared.debts.sort {($0.debtor?.fullName ?? "") > ($1.debtor?.fullName ?? "")} :
                DebtsViewModel.shared.debts.sort {($0.debtor?.fullName ?? "") < ($1.debtor?.fullName ?? "")}
            case .debt:
                selected.isDecrease ?
                DebtsViewModel.shared.debts.sort {($0.debtBalance + $0.interestBalance(defaultLastDate: Date())) > ($1.debtBalance + $1.interestBalance(defaultLastDate: Date()))} :
                DebtsViewModel.shared.debts.sort {($0.debtBalance + $0.interestBalance(defaultLastDate: Date())) < ($1.debtBalance + $1.interestBalance(defaultLastDate: Date()))}
            case .startDate:
                selected.isDecrease ?
                DebtsViewModel.shared.debts.sort {($0.startDate ?? Date()) > ($1.startDate ?? Date())} :
                DebtsViewModel.shared.debts.sort {($0.startDate ?? Date()) < ($1.startDate ?? Date())}
            case .endDate:
                selected.isDecrease ?
                DebtsViewModel.shared.debts.sort {($0.endDate ?? Date()) > ($1.endDate ?? Date())} :
                DebtsViewModel.shared.debts.sort {($0.endDate ?? Date()) < ($1.endDate ?? Date())}
        }
        
        DispatchQueue.main.async {
            UserDefaults.standard.set(self.selected.type.rawValue, forKey: UDKeys.sortType)
            UserDefaults.standard.set(self.selected.isDecrease, forKey: UDKeys.sortDecrease)
        }
        
    }
}
