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
    @EnvironmentObject private var historyVM: HistoryViewModel
    @EnvironmentObject private var adsVM: AdsViewModel
    
    @FetchRequest(
      entity: DebtCD.entity(),
      sortDescriptors: [
        NSSortDescriptor(keyPath: \DebtCD.closeDate, ascending: false)
      ],
      predicate: NSPredicate(format: "isClosed == %@", NSNumber(value: true))
    )
    private var debts: FetchedResults<DebtCD>
    @State private var showShareSheet = false
    @State private var showActivityIndicator = false
    
    var body: some View {
        
        NavigationView {
            
            if debts.isEmpty {
                EmptyDataAnimationView()
                    .navigationTitle(LocalStrings.NavBar.history)
            } else {
                
                LoadingView(isShowing: $showActivityIndicator, text: String(localized: "Preparing debts history")) {
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
                    
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button {
                                DispatchQueue.main.async {
                                    showActivityIndicator = true
                                }
                                historyVM.shareData = historyVM.prepareHistorytoExport(inputDebts: debts)
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                    showShareSheet = true
                                    showActivityIndicator = false
                                }
                            } label: {
                                Image(systemName: "square.and.arrow.up")
                            }
                        }
                    }
                    
                }
                
                .sheet(isPresented: $showShareSheet) {
                    ShareSheet(sharing: [historyVM.shareData])
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                adsVM.showInterstitial = true
                            }
                        }
                        .onDisappear {
                            
                        }
                    
                }

            }
            
        }

    }
}
