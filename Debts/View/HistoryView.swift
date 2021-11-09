//
//  HistoryView.swift
//  Debts
//
//  Created by Sergei Volkov on 14.04.2021.
//

import SwiftUI

struct HistoryView: View {
    
    @FetchRequest(
      entity: DebtCD.entity(),
      sortDescriptors: [
        NSSortDescriptor(keyPath: \DebtCD.startDate, ascending: true)
      ],
      predicate: NSPredicate(format: "isClosed == %@", NSNumber(value: true))
    )
    var debts: FetchedResults<DebtCD>
    
    
    var body: some View {
        
        NavigationView {
            List(debts) { debt in
                Text(debt.debtor?.fullName ?? "n/a")
            }
                .navigationTitle(LocalizedStringKey("History"))
        }
    }
}
