//
//  CurrencyView.swift
//  Debts
//
//  Created by Sergei Volkov on 10.04.2021.
//

import SwiftUI

struct CurrencyView: View {
    
    var body: some View {
        
        List {
            
            Section(header: Text("Favorites")) {
                ForEach(Currency.AllCurrency.favoritescurrency, id:\.self) { item in
                    CurrencyCell(item: item)
                }
            }
            
            Section(header: Text("All currency")) {
                ForEach(Currency.AllCurrency.arrayAllcurrency, id:\.self) { item in
                    CurrencyCell(item: item)
                }
            }
            
 
        }
        .listStyle(InsetGroupedListStyle())
        
        
        .navigationTitle(NSLocalizedString("Currency", comment: "navBarTitle"))
    }
}

struct CurrencyView_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyView()
    }
}
