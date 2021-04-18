//
//  DebtsViewModel.swift
//  Debts
//
//  Created by Sergei Volkov on 13.04.2021.
//

import SwiftUI
import CoreData

class DebtorsDebtsViewModel: ObservableObject {

    @Published var debtors: [DebtorCD]
    @Published var debts: [DebtCD]
    
    @Published var debtDetailPush = false
    @Published var debtorDetailPush = false
    
    init() {
        debtors = CDStack.shared.fetchDebtors()
        debts = CDStack.shared.fetchDebts()
    }

    func refreshData() {
        debtors = CDStack.shared.fetchDebtors()
        debts = CDStack.shared.fetchDebts()
    }
    func deleteDebt(debt: DebtCD) {
        CDStack.shared.container.viewContext.delete(debt)
        CDStack.shared.saveContext(context: CDStack.shared.container.viewContext)
        refreshData()
    }
    func deleteDebtor(debtor: DebtorCD) {
        CDStack.shared.container.viewContext.delete(debtor)
        CDStack.shared.saveContext(context: CDStack.shared.container.viewContext)
        refreshData()
    }
    
    
    func debtsMenuData(debt: DebtCD)->[[ActionMenuModel]] {
        return [
            [ActionMenuModel(title: NSLocalizedString("Detail info", comment: "action menu"),
                             systemIcon: "info.circle") {
                self.debtDetailPush.toggle()
             },
            ActionMenuModel(title: NSLocalizedString("Regular notification", comment: "action menu"),
                             systemIcon: "app.badge") {
                
             },
            ],
            
            [ActionMenuModel(title: NSLocalizedString("Debt payment", comment: "action menu"),
                             systemIcon: "dollarsign.circle") {
                 print("Close debt")
             },
             ActionMenuModel(title: NSLocalizedString("Defer debt", comment: "action menu"),
                             systemIcon: "calendar.badge.clock") {
                 print("Defer debt")
             },
             ActionMenuModel(title: NSLocalizedString("Edit debt", comment: "action menu"),
                             systemIcon: "square.and.pencil") {
                 print("Edit debt")
             },
             ActionMenuModel(title: NSLocalizedString("Delete debt", comment: "action menu"),
                             systemIcon: "trash") {
                withAnimation {
                    self.deleteDebt(debt: debt)
                }
                
             },
            ]

        ]
    }
    func debtorsMenuData(debtor: DebtorCD)->[[ActionMenuModel]] {
        return [
            [ActionMenuModel(title: NSLocalizedString("Detail info", comment: "action menu"),
                             systemIcon: "info.circle") {
                self.debtorDetailPush.toggle()
             },
            ActionMenuModel(title: NSLocalizedString("Call", comment: "action menu"),
                             systemIcon: "phone") {
                
             },
            ActionMenuModel(title: NSLocalizedString("Send SMS", comment: "action menu"),
                             systemIcon: "message") {
                
             },
            ],
            
            [ActionMenuModel(title: NSLocalizedString("Delete debtor", comment: "action menu"),
                             systemIcon: "trash") {
                withAnimation {
                    self.deleteDebtor(debtor: debtor)
                }
             },
            ]

        ]
    }
}
