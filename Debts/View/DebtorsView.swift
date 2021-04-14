//
//  DebtorsView.swift
//  Debts
//
//  Created by Sergei Volkov on 13.04.2021.
//

import SwiftUI

struct DebtorsView: View {
    
    @EnvironmentObject var debtorsDebt: DebtorsDebtsViewModel
    
    var body: some View {
        
        NavigationView {
            List {
                ForEach(debtorsDebt.debts) { item in
                    
                    HStack {
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .frame(width: 70, height: 70, alignment: .center)
                            .foregroundColor(Color(UIColor.systemGray))
                            .background(Color(UIColor.white))
                            .clipShape(Circle())
                        
                        VStack(alignment: .leading, spacing: 4) {
                            HStack {
                                Text(item.debtor.fristName)
                                Text(item.debtor.familyName ?? "")
                            }
                            .lineLimit(1)
                            .font(.system(size: 20, weight: .medium, design: .default))
                            
                            VStack(alignment: .leading, spacing: 0) {
                                HStack {
                                    Text("Total debt:")
                                    Text(debtorsDebt.getAllAmountOfDebtsOneDebtor(debtor: item.debtor).description)
                                        .font(.system(size: 20, weight: .bold, design: .default))
                                }
                                
                                Text("(include interest)")
                                    .font(.system(size: 10, weight: .light, design: .default))
                            }
                            
                        }
                        
                        
                        Spacer()
                    }
                    .modifier(CellModifire())
                    
                }
            }
            .navigationTitle(LocalizedStringKey("Debtors"))
        }  
        
    }
}

struct DebtorsView_Previews: PreviewProvider {
    static var previews: some View {
        DebtorsView()
            .environmentObject(DebtorsDebtsViewModel())
    }
}
