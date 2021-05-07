//
//  DebtorDetailView.swift
//  Debts
//
//  Created by Sergei Volkov on 17.04.2021.
//

import SwiftUI

struct DebtorDetailView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var debtor: DebtorCD
    
    var body: some View {
        
        VStack {
            PersonImage(size: 100)
                .padding()
            Text(debtor.fullName)
                .font(.title)
            
            HStack {
                VStack(alignment: .leading, spacing: 6) {
                    Text("Phone:")
                    Text("Email:")
                }
                VStack(alignment: .leading, spacing: 6) {
                    Text(debtor.phone ?? "n/a").fontWeight(.thin)
                    Text(debtor.email ?? "n/a").fontWeight(.thin)
                }
                Spacer()
            }.padding(.top, 6)
            Divider()
            Spacer()
        }
        .padding()
        
        .onDisappear() {
            presentationMode.wrappedValue.dismiss()
        }
        
        
        
        .navigationTitle(DebtorStatus.statusCDLocalize(status: "debtor"))
    }
}

//struct DebtorDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        DebtorDetailView(debtor: Debtor(fristName: "Alex",
//                                        familyName: "Bar",
//                                        phone: nil,
//                                        email: nil,
//                                        debts: []))
//    }
//}
