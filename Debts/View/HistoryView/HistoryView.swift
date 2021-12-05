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
            List(debts) { debt in
                VStack(alignment: .leading, spacing: 4) {
                    
                    DebtDetailHStackCell(firstColumn: NSLocalizedString("Closed", comment: " "),
                                         firstColumnDetail: nil,
                                         secondColumn: debt.closeDate?.formatted(date: .abbreviated, time: .shortened) ?? "")
                    
                    DebtDetailHStackCell(firstColumn: debt.localizeDebtStatus,
                                         firstColumnDetail: nil,
                                         secondColumn: debt.debtor?.fullName ?? "")
                    
                    HStack {
                        Text("Initial debt")
                            .fontWeight(.thin)
                        Spacer()
                        Text(currencyVM.currencyConvert(amount: debt.initialDebt as Decimal, currencyCode: debt.currencyCode))
                            .foregroundColor(DebtorStatus(rawValue: debt.debtorStatus) == DebtorStatus.debtor ? Color.green : Color.red)
                            .fontWeight(.bold)

                    }
                    
                    if debt.debtBalance != 0 {
                        HStack {
                            Text("Balance")
                                .fontWeight(.thin)
                            Spacer()
                            Text(currencyVM.debtBalanceFormat(debt: debt))
                                .foregroundColor(DebtorStatus(rawValue: debt.debtorStatus) == DebtorStatus.debtor ? Color.green : Color.red)
                                .fontWeight(.bold)
                        }
                    }
        
                    
                }

                .modifier(CellModifire(frameMinHeight: 40))
                .listRowBackground(Color.clear)
                
            }
            .listStyle(.plain)
            .modifier(BackgroundViewModifire())
            .navigationTitle(LocalizedStringKey("History"))
        }
    }
}
