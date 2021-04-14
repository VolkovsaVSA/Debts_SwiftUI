//
//  DebtsView.swift
//  Debts
//
//  Created by Sergei Volkov on 07.04.2021.
//

import SwiftUI



struct DebtsView: View {
    
    @EnvironmentObject var debtorsDebt: DebtorsDebtsViewModel
    @State var isActivate = false
  
    var body: some View {
        
        NavigationView {
            ScrollView {
                ForEach(debtorsDebt.debts) { item in
                    
                    DebtActionMenu(content:
                                    NavigationLink(
                                        destination: DebtDetailsView(),
                                        isActive: $isActivate,
                                        label: {
                                            DebtsCellView(item: item)
                                        }),
                                   actionData: menuData())
                }
                
            }
            .navigationTitle(LocalizedStringKey("Debts"))
        }
 
    }
    
    private func menuData()->[[MenuActionModel]] {
        return [
            [MenuActionModel(title: NSLocalizedString("Detail info", comment: ""),
                             systemIcon: "checkmark.circle") {
                isActivate.toggle()
             },
            MenuActionModel(title: NSLocalizedString("Regular notification", comment: ""),
                             systemIcon: "app.badge") {
                
             },
            ],
            
            [MenuActionModel(title: NSLocalizedString("Close debt", comment: ""),
                             systemIcon: "checkmark.circle") {
                 print("Close debt")
             },
             MenuActionModel(title: NSLocalizedString("Defer debt", comment: ""),
                             systemIcon: "calendar.badge.clock") {
                 print("Defer debt")
             },
             MenuActionModel(title: NSLocalizedString("Edit debt", comment: ""),
                             systemIcon: "square.and.pencil") {
                 print("Edit debt")
             },
             MenuActionModel(title: NSLocalizedString("Delete debt", comment: ""),
                             systemIcon: "trash") {
                 print("Delete debt")
             },
            ]

        ]
    }
    
}

struct DebtsView_Previews: PreviewProvider {
    static var previews: some View {
        DebtsView()
            .environmentObject(DebtorsDebtsViewModel())
    }
}
