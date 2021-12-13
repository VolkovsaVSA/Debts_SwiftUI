//
//  DebtorDetailView.swift
//  Debts
//
//  Created by Sergei Volkov on 17.04.2021.
//

import SwiftUI
import MessageUI

struct DebtorDetailView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var debtor: DebtorCD

    @State private var sheet: SheetType?
    @State private var mailResult: Result<MFMailComposeResult, Error>? = nil
    @State private var editMode = false
    @State private var buttonChange = false
    @State private var hideNameSection = false
    
    @State private var showActivityIndicator = false
    
    var body: some View {
        
        
        if editMode {
            LoadingView(isShowing: $showActivityIndicator, text: NSLocalizedString("Image compression", comment: " ")) {
                DebtorDataEditView(debtor: debtor, showActivityIndicator: $showActivityIndicator) {
                    withAnimation {
                        editMode.toggle()
                    }
                    buttonChange.toggle()
                }

            }
            .zIndex(1)
        }
        
        List {
            
            if !buttonChange {
                DebtorDetailPersonInfoView(debtor: debtor)
            }

            if debtor.fetchDebts(isClosed: false).isEmpty {
                HStack {
                    Spacer()
                    Text("No active debts")
                    Spacer()
                }
                .modifier(CellModifire(frameMinHeight: 10, useShadow: true))
            } else {
                HStack {
                    Spacer()
                    Text(debtor.fetchDebts(isClosed: false).count.description)
                        .fontWeight(.semibold)
                    Text("active debts")
                    Spacer()
                }
                .modifier(CellModifire(frameMinHeight: 10, useShadow: false))
                
                ForEach(debtor.fetchDebts(isClosed: false), id: \.self) { debt in
                    DebtorDetailCellView(debt: debt)
                        .modifier(CellModifire(frameMinHeight: 10, useShadow: true))
                        .background(
                            NavigationLink(destination: DebtDetailsView(debt: debt)) {EmptyView()}
                                .opacity(0)
                        )
                    
                }
            }

        }
        .disabled(editMode)
        .foregroundColor(editMode ? Color.secondary : Color.primary)
        .listStyle(.plain)
        .modifier(BackgroundViewModifire())
        .onDisappear() {
            dismiss()
        }
        .navigationTitle(debtor.fullName).ignoresSafeArea(.keyboard , edges: .all)
        
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    DebtsViewModel.shared.editedDebtor = debtor
                    buttonChange.toggle()
                    withAnimation {
                        editMode.toggle()
                    }
                } label: {
                    Image(systemName: buttonChange ? "plus.circle.fill" : "square.and.pencil")
                        .rotationEffect(buttonChange ? .degrees(45) : .degrees(0))
                }
            }
        }
        
    }
}
