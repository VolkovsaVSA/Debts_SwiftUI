//
//  HistoryView.swift
//  Debts
//
//  Created by Sergei Volkov on 14.04.2021.
//

import SwiftUI

struct HistoryView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject private var currencyVM: CurrencyViewModel
    
    @State private var lottieID = UUID()
    
    @FetchRequest(
      entity: DebtCD.entity(),
      sortDescriptors: [
        NSSortDescriptor(keyPath: \DebtCD.closeDate, ascending: false)
      ],
      predicate: NSPredicate(format: "isClosed == %@", NSNumber(value: true))
    )
    private var debts: FetchedResults<DebtCD>
    
    
    var body: some View {
        
        NavigationView {
            
            if debts.isEmpty {
                LottieContainerView()
                    .id(lottieID)
                    .onAppear {
                        lottieID = UUID()
                    }
                    .navigationTitle(LocalStrings.NavBar.history)
            } else {
                List {
                    Section(header: HistoryHeaderView().foregroundColor(.primary)) {
                        ForEach(debts) { debt in
                            HistoryCellView(debt: debt)
                                .background(
                                    NavigationLink(destination: DebtDetailsView(debt: debt)) {EmptyView()}
                                        .opacity(0)
                                )
                                .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                                    Button(role: .destructive) {
                                        withAnimation {
                                            viewContext.delete(debt)
                                        }
                                    } label: {
                                        Label(LocalStrings.Button.delete, systemImage: "trash")
                                    }
                                }
                        }
                        .id(HistoryViewModel.shared.refreshedID)
                    }
                }
                .listStyle(.plain)
                .navigationTitle(LocalStrings.NavBar.history)
            }
            
        }
    }
}
