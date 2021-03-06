//
//  DebtorsView.swift
//  Debts
//
//  Created by Sergei Volkov on 13.04.2021.
//

import SwiftUI

struct DebtorsView: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject private var debtsVM: DebtsViewModel
    @FetchRequest(fetchRequest: DebtorCD.fetchRequest())
    private var debtors: FetchedResults<DebtorCD>
    
    @StateObject var selectedSortDebtorsObject: SortDebtorsObject
    @State private var alertPresent = false
    @State private var addDebtorPresent = false
    @State private var deleteDebtor: DebtorCD!
    
    var body: some View {
        
        NavigationView {
            
            if debtors.isEmpty {
                EmptyDataAnimationView()
                    .navigationTitle(LocalStrings.NavBar.debtors)
            } else {

                
                
                List {
                    
                    if !UserDefaults.standard.bool(forKey: IAPProducts.fullVersion.rawValue) {
                        AdsManager.BannerVC(size: CGSize(width: UIScreen.main.bounds.width - 24, height: 50))
                            .listRowSeparator(.hidden)
                            .listRowBackground(Color.clear)
                            .frame(minHeight: 50)
                            .lineLimit(nil)
                            .background(colorScheme == .dark ? .thinMaterial : .regularMaterial)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .modifier(ShadowButtonModifire(useShadow: true))
                    }
                    
                    ForEach(debtors) { debtor in
                        DebtorsCellView(debtor: debtor)
                            .background(
                                NavigationLink(destination: DebtorDetailView(debtor: debtor)) {EmptyView()}
                                    .opacity(0)
                            )
                            .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                                Button(role: .destructive) {
                                    deleteDebtor = debtor
                                    alertPresent.toggle()
                                } label: {
                                    Label(LocalStrings.Button.delete, systemImage: "trash")
                                }
                            }
                    }

                }
                .listStyle(.plain)
                .navigationTitle(LocalStrings.NavBar.debtors)
                
                .alert(LocalStrings.Alert.Title.deleteDebtor, isPresented: $alertPresent) {
                    Button(LocalStrings.Button.deleteDebtor, role: .destructive) {
                        withAnimation {
                            debtsVM.deleteDebtor(debtor: deleteDebtor)
                        }
                    }
                } message: {
                    Text(LocalStrings.Alert.Text.ifYouDeleteDebtor)
                }
                
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        
                        Menu {
                            ForEach(selectedSortDebtorsObject.sortArray) { item in
                                Button {
                                    selectedSortDebtorsObject.selected = item
                                    debtors.sortDescriptors = selectedSortDebtorsObject.convertSortDescriptors
                                } label: {
                                    HStack {
                                        Image(systemName: selectedSortDebtorsObject.selected == item ? "checkmark" : "")
                                        Text(SortDebtorsType.localizedSortType(item))
                                    }
                                }
                            }
                        } label: {
                            SortImageForLabel()
                        }

                    }
                }
            }

                
        }

    }

}
