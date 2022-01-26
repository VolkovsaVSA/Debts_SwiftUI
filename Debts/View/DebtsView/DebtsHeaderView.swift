//
//  DebtsHeaderView.swift
//  Debts
//
//  Created by Sergei Volkov on 25.01.2022.
//

import SwiftUI

struct DebtsHeaderView: View {
    @EnvironmentObject private var currencyVM: CurrencyViewModel
    
    @FetchRequest(
      entity: DebtCD.entity(),
      sortDescriptors: [
        NSSortDescriptor(keyPath: \DebtCD.startDate, ascending: true)
      ],
      predicate: NSPredicate(format: "isClosed == %@", NSNumber(value: false))
    )
    private var debts: FetchedResults<DebtCD>
    
    
    var body: some View {
        
        VStack {
            HStack {
                Text(LocalStrings.Views.DebtorsView.activeDebts + ": \(debts.count)")
                Spacer()
                Text(LocalStrings.Views.DebtorsView.totalDebt)
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(calculateTotalDebt()) { item in
                        Text(currencyVM.currencyConvert(amount: item.amount, currencyCode: item.currencyCode))
                            .foregroundColor(item.amount > 0 ? .green : (item.amount < 0 ? .red : .gray))
                            .fontWeight(.bold)
                    }
                }
                
            }
            .modifier(CellModifire(frameMinHeight: 10, useShadow: false))
        }

    }
    
    private func calculateTotalDebt()-> [DebtorsDebtsModel] {
        var debtsAmount = [DebtorsDebtsModel]()
        
        debts.forEach { debt in
            let tempModel = DebtorsDebtsModel(currencyCode: debt.currencyCode,
                                              amount:
                                                SettingsViewModel.shared.totalAmountWithInterest ?
                                              debt.debtBalance +
                                              debt.interestBalance(defaultLastDate: Date()) +
                                              debt.penaltyBalance(toDate: Date())
                                              :
                                                debt.debtBalance
            )
            
            if debtsAmount.contains(where: { model in
                if debt.currencyCode == model.currencyCode {
                    return true
                } else {
                    return false
                }
            }) {
                
                guard var temp = debtsAmount.filter({ $0.currencyCode == tempModel.currencyCode }).first else {return}
                
                if debt.debtorStatus == DebtorStatus.debtor.rawValue {
                    temp.amount += tempModel.amount
                } else {
                    temp.amount -= tempModel.amount
                }
//                
//                temp.amount += tempModel.amount
//                
                for (index, value) in debtsAmount.enumerated() {
                    if value.currencyCode == tempModel.currencyCode {
                        debtsAmount[index] = temp
                    }
                }
                
            } else {
                debtsAmount.append(tempModel)
            }
            
        }
        
        return debtsAmount.sorted() { $0.amount > $1.amount }
    }
}
