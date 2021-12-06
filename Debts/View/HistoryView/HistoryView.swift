//
//  HistoryView.swift
//  Debts
//
//  Created by Sergei Volkov on 14.04.2021.
//

import SwiftUI

struct HistoryView: View {
    
    @EnvironmentObject private var currencyVM: CurrencyViewModel
    
    @FetchRequest(
      entity: DebtCD.entity(),
      sortDescriptors: [
        NSSortDescriptor(keyPath: \DebtCD.closeDate, ascending: false)
      ],
      predicate: NSPredicate(format: "isClosed == %@", NSNumber(value: true))
    )
    var debts: FetchedResults<DebtCD>
    
    
    
    
    var body: some View {
        
        NavigationView {
            
            if debts.isEmpty {
                NoDataBanner(text: LocalizedStringKey("No debts in history"))
                .modifier(BackgroundViewModifire())
                .navigationTitle(LocalizedStringKey("History"))
            } else {
                List {
                    Section(header: Text("Total \(debts.count) debts").foregroundColor(.primary)) {
                        ForEach(debts) { debt in
                            HistoryCellView(debt: debt)
                                .background(
                                    NavigationLink(destination: DebtDetailsView(debt: debt)) {EmptyView()}
                                        .opacity(0)
                                )
                        }
                        .modifier(DebtDetailCellModifire())
                    }
                }
                .listStyle(.plain)
                .modifier(BackgroundViewModifire())
                .navigationTitle(LocalizedStringKey("History"))
            }

            
        }
    }
}
