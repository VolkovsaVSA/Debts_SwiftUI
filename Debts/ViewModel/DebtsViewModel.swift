//
//  DebtsViewModel.swift
//  Debts
//
//  Created by Sergei Volkov on 13.04.2021.
//

import SwiftUI
import CoreData
import WidgetKit

final class DebtsViewModel: ObservableObject {
    
    static let shared = DebtsViewModel()
    
    @Published var refreshID = UUID()
    @Published var debtors: [DebtorCD]
    @Published var debts: [DebtCD]
    @Published var debtDetailPush = false
    @Published var selectedDebt: DebtCD?
    @Published var debtSheet: SheetType?
    @Published var debtorDetailPush = false
    @Published var actionSheettitle: LocalizedStringKey = ""
    
    @Published var editDebtorMode = false
    
    init() {
        debtors = CDStack.shared.fetchDebtors()
        debts = CDStack.shared.fetchDebts(isClosed: false)
    }
    
    func refreshData() {
        debtors = CDStack.shared.fetchDebtors()
        debts = CDStack.shared.fetchDebts(isClosed: false)
        refreshID = UUID()
        WidgetCenter.shared.reloadAllTimelines()
    }
    func deleteDebt(debt: DebtCD) {
        if let id = debt.id {
            NotificationManager.removeNotifications(identifiers: [id.uuidString])
        }
        CDStack.shared.persistentContainer.viewContext.delete(debt)
        CDStack.shared.saveContext(context: CDStack.shared.persistentContainer.viewContext)
        refreshData()
    }
    func deleteDebtor(debtor: DebtorCD) {
        let ids = CDStack.shared.fetchDebts(isClosed: false).filter {$0.debtor == debtor}.compactMap {$0.id?.uuidString}
        NotificationManager.removeNotifications(identifiers: ids)
        
        CDStack.shared.persistentContainer.viewContext.delete(debtor)
        CDStack.shared.saveContext(context: CDStack.shared.persistentContainer.viewContext)
        refreshData()
    }

}
