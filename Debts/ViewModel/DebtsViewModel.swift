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
    
    init() {
        debtors = CDStack.shared.fetchDebtors()
        debts = CDStack.shared.fetchDebts()
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
        debts = CDStack.shared.fetchDebts()
        refreshID = UUID()
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
    
    
//    func debtsMenuData(debt: DebtCD)->[[ActionMenuModel]] {
//        return [
//            [ActionMenuModel(title: NSLocalizedString("Detail info", comment: "action menu"),
//                             systemIcon: "info.circle") {
//                self.selectedDebt = debt
//                self.debtDetailPush = true
//             },
//            ActionMenuModel(title: NSLocalizedString("Payment notification", comment: "action menu"),
//                             systemIcon: "app.badge") {
//
//             },
//            ],
//
//            [ActionMenuModel(title: NSLocalizedString("Add payment", comment: "action menu"),
//                             systemIcon: "dollarsign.circle") {
//                self.selectedDebt = debt
//                self.debtSheet = .debtPayment
//             },
//             ActionMenuModel(title: NSLocalizedString("Edit debt", comment: "action menu"),
//                             systemIcon: "square.and.pencil") {
//                AddDebtViewModel.shared.editedDebt = debt
//                self.debtSheet = .addDebtViewPresent
//             },
//             ActionMenuModel(title: NSLocalizedString("Delete debt", comment: "action menu"),
//                             systemIcon: "trash") {
//                withAnimation {
//                    self.deleteDebt(debt: debt)
//                }
//
//             },
//            ]
//
//        ]
//    }
//    func debtorsMenuData(debtor: DebtorCD)->[[ActionMenuModel]] {
//        return [
//            [ActionMenuModel(title: NSLocalizedString("Detail info", comment: "action menu"),
//                             systemIcon: "info.circle") {
//                self.debtorDetailPush.toggle()
//             },
//            ActionMenuModel(title: NSLocalizedString("Call", comment: "action menu"),
//                             systemIcon: "phone") {
//                
//             },
//            ActionMenuModel(title: NSLocalizedString("Send SMS", comment: "action menu"),
//                             systemIcon: "message") {
//                
//             },
//            ],
//            
//            [ActionMenuModel(title: NSLocalizedString("Delete debtor", comment: "action menu"),
//                             systemIcon: "trash") {
//                withAnimation {
//                    self.deleteDebtor(debtor: debtor)
//                }
//             },
//            ]
//
//        ]
//    }
}
