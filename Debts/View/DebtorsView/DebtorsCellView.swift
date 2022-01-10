//
//  DebtorsCellView.swift
//  Debts
//
//  Created by Sergei Volkov on 14.04.2021.
//

import SwiftUI

struct DebtorsCellView: View {
    
    @EnvironmentObject private var debtsVM: DebtsViewModel
    @EnvironmentObject private var currencyVM: CurrencyViewModel
    @EnvironmentObject private var settingsVM: SettingsViewModel
    
    @State var debtor: DebtorCD
    @State private var refresh = UUID()
    
    var body: some View {
        
        HStack {
            
            PersonImage(image: debtor.image)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(debtor.fullName)
                    .lineLimit(2)
                    .font(.system(size: 20, weight: .medium, design: .default))
                
                VStack(alignment: .leading, spacing: 0) {
                    
                    HStack(alignment: .top) {
                        
                        if debtor.fetchDebts(isClosed: false).isEmpty {
                            Text(LocalStrings.Views.DebtorsView.noActiveDebts)
                                .fontWeight(.thin)
                        } else {
                            VStack {
                                Text(LocalStrings.Views.DebtorsView.totalDebt)
                                
                                if settingsVM.totalAmountWithInterest {
                                    Text(LocalStrings.Views.DebtorsView.includeInterestAndPenalties)
                                        .lineLimit(2)
                                        .multilineTextAlignment(.leading)
                                        .font(.system(size: 10, weight: .light, design: .default))
                                }
                                
                            }
                            VStack(alignment: .leading) {
                                ForEach(debtor.allDebtsDebtorsDebtsModel, id:\.self) { debt in
                                    HStack(spacing: 0) {
                                        if debt.amount > 0 {
                                            Text("+")
                                                .font(.system(size: 17, weight: .bold, design: .default))
                                        }
                                        Text(currencyVM.currencyConvert(amount: debt.amount, currencyCode: debt.currencyCode))
                                            .font(.system(size: 17, weight: .bold, design: .default))
                                            .minimumScaleFactor(0.5)
                                    }
                                    .foregroundColor(debt.amount > 0 ? Color.green: Color.red)
                                }
                            }
                        }
                        
                        
                       
                        
                        
                    }.id(refresh)
                }
                
            }
            
            Spacer()
        }
        .onChange(of: settingsVM.totalAmountWithInterest, perform: { _ in
            refresh = UUID()
        })
        .modifier(CellModifire(frameMinHeight: AppSettings.cellFrameMinHeight, useShadow: true))
        
    }
}
