//
//  DebtorDetailView.swift
//  Debts
//
//  Created by Sergei Volkov on 17.04.2021.
//

import SwiftUI
import MessageUI

struct DebtorDetailView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @ObservedObject var debtor: DebtorCD

    @State private var sheet: SheetType?
    @State private var mailResult: Result<MFMailComposeResult, Error>? = nil
    @State private var editMode = false
    @State private var buttonChange = false
    @State private var hideNameSection = false
    
    @State private var showActivityIndicator = false
    
    var body: some View {
        
        ZStack {
            
            if editMode {
                LoadingView(isShowing: $showActivityIndicator, text: LocalStrings.Other.imageCompression) {
                    DebtorDataEditView(debtor: debtor, showActivityIndicator: $showActivityIndicator) {
                        withAnimation {
                            editMode.toggle()
                        }
                        buttonChange.toggle()
                    }
                    .modifier(CellModifire(frameMinHeight: 10, useShadow: true))
                }
                .zIndex(1)
            }
            
            List {
                
                DebtorDetailPersonInfoView(debtor: debtor)

                if debtor.fetchDebts(isClosed: false).isEmpty {
                    HStack {
                        Spacer()
                        Text(LocalStrings.Views.DebtorsView.noActiveDebts)
                        Spacer()
                    }
                    .modifier(CellModifire(frameMinHeight: 10, useShadow: false))
                } else {
                    HStack {
                        Spacer()
                        Text(debtor.fetchDebts(isClosed: false).count.description)
                            .fontWeight(.semibold)
                        Text(LocalStrings.Views.DebtorsView.activeDebts)
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

            }.zIndex(0)
            
            .disabled(editMode)
            .foregroundColor(editMode ? Color.secondary : Color.primary)
            .listStyle(.plain)
            .onDisappear() {
                dismiss()
            }
            
            
        }
        .navigationTitle(debtor.fullName)
        .navigationBarTitleDisplayMode(editMode ? (UIDevice.current.userInterfaceIdiom == .pad ? .automatic : .inline) : .automatic)
        
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
