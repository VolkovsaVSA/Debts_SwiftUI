//
//  CustomActionSheet.swift
//  Debts
//
//  Created by Sergei Volkov on 29.11.2021.
//

import SwiftUI

struct CustomActionSheet: View {
    
    let debtorsMatching: [DebtorCD]
    
    let geometry: GeometryProxy
    
    var body: some View {
        
        VStack(spacing: 15) {
            
            Text("You have similar contacts in debtors. For new debts, use already created debtors.")
                .foregroundColor(Color(UIColor.label))
                .lineLimit(3)
                .multilineTextAlignment(.center)
                .font(Font.system(size: 16, weight: .bold, design: .default))
            
            ForEach(debtorsMatching, id: \.self) { item in
                Button {
                    AddDebtViewModel.shared.selectedDebtor = item
                    AddDebtViewModel.shared.checkDebtor()
                    withAnimation {
                        AddDebtViewModel.shared.showDebtorWarning.toggle()
                    }
                } label: {
                    VStack(alignment: .leading) {
                        HStack {
                            Text(item.fullName)
                                .fontWeight(.bold)
                            Spacer()
                            if let debtorsDebts = item.debts {
                                Text("debts: ")
                                Text(debtorsDebts.count.description)
                            }
                        }
                        
                        if let debtorPhone = item.phone {
                            HStack {
                                Text(debtorPhone)
                            }
                        }
                        
                    }
                        .frame(width: geometry.size.width * 0.9)
                        .padding(8)
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .foregroundColor(.blue)
                        )
                }
            }
            
            
            Button {
                withAnimation {
                    AddDebtViewModel.shared.showDebtorWarning.toggle()
                }
            } label: {
                Text("Use data from contacts")
                    .frame(width: geometry.size.width * 0.9)
                    .padding(8)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .foregroundColor(.red)
                    )
            }
            
        }
        .foregroundColor(.white)
        .frame(width: geometry.size.width
//               , height: CGFloat(debtorsMatching.count) * 44
        )
        .padding(.top, 20)
        .padding(.bottom, 40)
        .background(
            Color.init(UIColor.systemBackground)
        )
        .cornerRadius(25)
        
    }
}


