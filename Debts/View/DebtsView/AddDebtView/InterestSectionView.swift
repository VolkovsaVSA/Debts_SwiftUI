//
//  InterestSectionView.swift
//  Debts
//
//  Created by Sergei Volkov on 14.07.2021.
//

import SwiftUI

struct InterestSectionView: View {
    
    @EnvironmentObject private var addDebtVM: AddDebtViewModel
    
    var body: some View {
        
        Section(header: Toggle("Interest charge", isOn: $addDebtVM.isInterest.animation()),
                footer: addDebtVM.isInterest ? AnyView(Text("Interest is charged either on the original amount of the debt or on the balance of the debt.")) : AnyView(EmptyView()) ) {
            
            if addDebtVM.isInterest {
                HStack {
                    TextField("Interest", text: $addDebtVM.percent)
                        .keyboardType(.decimalPad)
                        .submitLabel(.done)
                    Spacer()
                    Picker("% \(PercentType.percentTypeConvert(type: addDebtVM.selectedPercentType))", selection: $addDebtVM.selectedPercentType) {
                        ForEach(PercentType.allCases, id: \.self) { type in
                            Text(PercentType.percentTypeConvert(type: type))
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .modifier(SimpleButtonModifire(textColor: .white,
                                                   buttonColor: AppSettings.accentColor,
                                                   frameWidth: 140))
                    
                    
                    .lineLimit(1)
                }
                
                HStack {
                    Text("Interest calculation method")
                        .lineLimit(2)
                        .font(.system(size: 17, weight: .thin, design: .default))
                    Spacer()
                    Picker(addDebtVM.convertedPercentBalanceType, selection: $addDebtVM.percentBalanceType) {
                        Text(LocalStrings.Views.AddDebtView.initialDebt).tag(0)
                        Text(LocalStrings.Views.AddDebtView.balanceOfDebt).tag(1)
                    }
                    .pickerStyle(MenuPickerStyle())
                    .modifier(SimpleButtonModifire(textColor: .white,
                                                   buttonColor: AppSettings.accentColor,
                                                   frameWidth: 140))
                    
                }
   
            }
            
        }
        .listRowSeparator(.hidden)
        
    }
}
