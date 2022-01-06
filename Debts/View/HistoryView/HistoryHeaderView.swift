//
//  HistoryHeaderView.swift
//  Debts
//
//  Created by Sergei Volkov on 13.12.2021.
//

import SwiftUI

struct HistoryHeaderView: View {
    @EnvironmentObject private var currencyVM: CurrencyViewModel
    
    @FetchRequest(
      entity: DebtCD.entity(),
      sortDescriptors: [
        NSSortDescriptor(keyPath: \DebtCD.closeDate, ascending: false)
      ],
      predicate: NSPredicate(format: "isClosed == %@", NSNumber(value: true))
    )
    private var debts: FetchedResults<DebtCD>
    
    
    var body: some View {
        
        VStack {
            HStack {
                Text("Total closed \(debts.count) debts")
                Spacer()
                Text("Profit:")
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(calculateProfit()) { item in
                        Text(currencyVM.currencyConvert(amount: item.amount, currencyCode: item.currencyCode))
                            .foregroundColor(item.amount > 0 ? .green : (item.amount < 0 ? .red : .gray))
                            .fontWeight(.bold)
                    }
                }
                
            }
            .modifier(CellModifire(frameMinHeight: 10, useShadow: false))
        }

    }
    
    private func calculateProfit()-> [DebtorsDebtsModel] {
        var debtsAmount = [DebtorsDebtsModel]()
        
        debts.forEach { debt in
            let tempModel = DebtorsDebtsModel(currencyCode: debt.currencyCode,
                                              amount: debt.profitBalance)
            
            if debtsAmount.contains(where: { model in
                if debt.currencyCode == model.currencyCode {
                    return true
                } else {
                    return false
                }
            }) {
                
                guard var temp = debtsAmount.filter({ $0.currencyCode == tempModel.currencyCode }).first else {return}
                temp.amount += tempModel.amount
                
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
