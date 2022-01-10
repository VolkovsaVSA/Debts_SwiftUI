//
//  PenaltySectionView.swift
//  Debts
//
//  Created by Sergei Volkov on 14.07.2021.
//

import SwiftUI

struct PenaltySectionView: View {
    
    @EnvironmentObject private var addDebtVM: AddDebtViewModel
    @EnvironmentObject private var currencyVM: CurrencyViewModel
    
    var body: some View {
        
        Section(header: Toggle(LocalStrings.Views.AddDebtView.penaltyForDebtRepayDelay, isOn: $addDebtVM.isPenalty.animation())
                    .tint(AppSettings.accentColor),
                footer: (addDebtVM.isPenalty && addDebtVM.penaltyType == .dynamic) ? AnyView(Text(LocalStrings.Views.AddDebtView.accrualOfPenaltiesForDelayedDebt)) : AnyView(EmptyView()) ) {
            
            if addDebtVM.isPenalty {
                HStack {
                    Spacer()
                    Text(LocalStrings.Views.AddDebtView.typeOfpenalty).font(.headline)
                    Spacer()
                }
                
                Picker("", selection: $addDebtVM.penaltyType.animation()) {
                    ForEach(PenaltyType.allCases, id: \.self) {
                        Text(PenaltyType.penaltyTypeCDLocalize(type: $0.rawValue))
                    }
                }
                .pickerStyle(.segmented)
                
                if addDebtVM.penaltyType == .fixed {
                    HStack {
                        Text(Currency.presentCurrency(code: currencyVM.selectedCurrency.currencyCode).currencySymbol)
                        TextField(LocalStrings.Views.AddDebtView.amountOfFixedPenalty, text: $addDebtVM.penaltyFixedAmount)
                            .keyboardType(.decimalPad)
                    }
                    
                } else {
                    
                    Picker("", selection: $addDebtVM.penaltyDynamicType.animation()) {
                        ForEach(PenaltyType.DynamicType.allCases, id: \.self) {
                            Text(PenaltyType.DynamicType.dynamicTypeCDLocalize(type: $0.rawValue))
                        }
                    }
                    .pickerStyle(.segmented)
                    
                    HStack {
                        if addDebtVM.penaltyDynamicType == .amount {
                            Text(Currency.presentCurrency(code: currencyVM.selectedCurrency.currencyCode).currencySymbol)
                        } else {
                            Text("%")
                        }
                        TextField("\(PenaltyType.DynamicType.dynamicTypeCDLocalize(type: addDebtVM.penaltyDynamicType.rawValue)) of dynamic penalty", text: $addDebtVM.penaltyDynamicValue)
                            .keyboardType(.decimalPad)
                    }
                    
                    if addDebtVM.penaltyDynamicType == .percent {
                        Picker(LocalStrings.Views.AddDebtView.calculationMethod, selection: $addDebtVM.penaltyDynamicPercentChargeType.animation()) {
                            ForEach(PenaltyType.DynamicType.PercentChargeType.allCases, id: \.self) {
                                Text(PenaltyType.DynamicType.PercentChargeType.percentChargeTypeCDLocalize(type: $0.rawValue))
                            }
                        }
                    }
                    
                    Picker(LocalStrings.Views.AddDebtView.dynamicPeriod, selection: $addDebtVM.penaltyDynamicPeriod.animation()) {
                        ForEach(PenaltyType.DynamicType.DynamicPeriod.allCases, id: \.self) {
                            Text(PenaltyType.DynamicType.DynamicPeriod.dynamicPeriodCDLocalize(period: $0.rawValue))
                        }
                    }
                    
                }
                
                
            }
            
        }
        .listRowSeparator(.hidden)
        
    }
}

