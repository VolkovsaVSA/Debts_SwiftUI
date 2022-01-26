//
//  DebtDetailsView.swift
//  Debts
//
//  Created by Sergei Volkov on 14.04.2021.
//

import SwiftUI

struct DebtDetailsView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var adsVM: AdsViewModel
    
    private var navTtile: String {
        return debt.debtorStatus == DebtorStatus.debtor.rawValue ? LocalStrings.NavBar.debtDetail : LocalStrings.NavBar.creditDetail
    }
    
    @ObservedObject var debt: DebtCD
    
    @State private var showShareSheet = false
    @State private var showActivityIndicator = false
    
    var shareData: String {
        var result = Date().formatted(date: .abbreviated, time: .complete)
        result.append("\n")
        result.append(String(localized: "History debts of "))
        result.append(AppId.displayName ?? "")
        result.append("\n")
        result.append(AppId.appUrl?.absoluteString ?? "")
        result.append("\n\n")
        result.append(HistoryViewModel.shared.prepareHistoryOneDebt(debt: debt))
        return result
    }
    
    var body: some View {

        Form {
            DebtDetailSection(debt: debt, isPaymentView: false, lastDateForAddedPaymentview: nil)
            PaymentsView(debt: debt, isEditable: false)
        }
        .listStyle(.grouped)
        .onDisappear() {
            DebtsViewModel.shared.selectedDebt = nil
            dismiss()
        }
        .navigationTitle(navTtile)
        
        .navigationTitle(navTtile)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    showShareSheet = true
                } label: {
                    Image(systemName: "square.and.arrow.up")
                }
            }
        }
        
        .sheet(isPresented: $showShareSheet) {
            ShareSheet(sharing: [shareData])
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        adsVM.showInterstitial = true
                    }
                }
        }
    }
    
}
