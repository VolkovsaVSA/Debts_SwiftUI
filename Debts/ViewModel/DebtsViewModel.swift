//
//  DebtsViewModel.swift
//  Debts
//
//  Created by Sergei Volkov on 13.04.2021.
//

import SwiftUI
import CoreData

class DebtorsDebtsViewModel: ObservableObject {
    
//    @FetchRequest(
//        entity: ListCD.entity(),
//        sortDescriptors: [NSSortDescriptor(keyPath: \ListCD.dateAdded, ascending: true)]
//    )
//    var lists: FetchedResults<ListCD>
    
    
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
            [ActionMenuModel(title: NSLocalizedString("Detail info", comment: ""),
                             systemIcon: "info.circle") {
                self.debtDetailPush.toggle()
             },
            ActionMenuModel(title: NSLocalizedString("Regular notification", comment: ""),
                             systemIcon: "app.badge") {
                
             },
            ],
            
            [ActionMenuModel(title: NSLocalizedString("Close debt", comment: ""),
                             systemIcon: "checkmark.circle") {
                 print("Close debt")
             },
             ActionMenuModel(title: NSLocalizedString("Defer debt", comment: ""),
                             systemIcon: "calendar.badge.clock") {
                 print("Defer debt")
             },
             ActionMenuModel(title: NSLocalizedString("Edit debt", comment: ""),
                             systemIcon: "square.and.pencil") {
                 print("Edit debt")
             },
             ActionMenuModel(title: NSLocalizedString("Delete debt", comment: ""),
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
            [ActionMenuModel(title: NSLocalizedString("Detail info", comment: ""),
                             systemIcon: "info.circle") {
                self.debtorDetailPush.toggle()
             },
            ActionMenuModel(title: NSLocalizedString("Call", comment: ""),
                             systemIcon: "phone") {
                
             },
            ActionMenuModel(title: NSLocalizedString("Send SMS", comment: ""),
                             systemIcon: "message") {
                
             },
            ],
            
            [ActionMenuModel(title: NSLocalizedString("Delete debtor", comment: ""),
                             systemIcon: "trash") {
                withAnimation {
                    self.deleteDebtor(debtor: debtor)
                }
             },
            ]

        ]
    }
}
