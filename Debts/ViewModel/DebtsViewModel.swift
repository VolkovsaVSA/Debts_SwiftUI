//
//  DebtsViewModel.swift
//  Debts
//
//  Created by Sergei Volkov on 13.04.2021.
//

import SwiftUI
import CoreData

class DebtsViewModel: ObservableObject {
    
    @Published var refreshID = UUID()
    
    static let shared = DebtsViewModel()

    @Published var debtors: [DebtorCD]
    @Published var debts: [DebtCD]
    
    @Published var debtDetailPush = false
    @Published var selectedDebt: DebtCD?
    @Published var debtSheet: SheetType?
   
    @Published var debtorDetailPush = false
    
    @Published var actionSheettitle: LocalizedStringKey = ""
    
    
    init() {
        debtors = CDStack.shared.fetchDebtors()
        debts = CDStack.shared.fetchDebts(isClosed: false)
    }
    
    func selecetedView()-> AnyView {
        if selectedDebt != nil {
            return AnyView(DebtDetailsView(debt: selectedDebt!))
        } else {
            return AnyView(EmptyView())
        }
    }

    func refreshData() {
        debtors = CDStack.shared.fetchDebtors()
        debts = CDStack.shared.fetchDebts(isClosed: false)
        refreshID = UUID()
    }
    func deleteDebt(debt: DebtCD) {
        if let id = debt.id {
            NotificationManager.removeNotifications(identifiers: [id.uuidString])
        }
        CDStack.shared.container.viewContext.delete(debt)
        CDStack.shared.saveContext(context: CDStack.shared.container.viewContext)
        refreshData()
    }
    func deleteDebtor(debtor: DebtorCD) {
        
        let ids = CDStack.shared.fetchDebts(isClosed: false).filter {$0.debtor == debtor}.compactMap {$0.id?.uuidString}
        NotificationManager.removeNotifications(identifiers: ids)
        
        CDStack.shared.container.viewContext.delete(debtor)
        CDStack.shared.saveContext(context: CDStack.shared.container.viewContext)
        refreshData()
    }

    
}
