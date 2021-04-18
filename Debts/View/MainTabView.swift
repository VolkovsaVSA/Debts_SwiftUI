//
//  ContentView.swift
//  Debts
//
//  Created by Sergei Volkov on 01.03.2021.
//

import SwiftUI
import CoreData

struct MainTabView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @EnvironmentObject var addDebtVM: AddDebtViewModel
    @EnvironmentObject var currencyListVM: CurrencyListViewModel
    @EnvironmentObject var debtorsDebt: DebtorsDebtsViewModel
    
    @State private var sheet: SheetType?

    var body: some View {
        
        GeometryReader { geometry in
            ZStack {
                TabView {
                    
                    DebtsView()
                            .padding(.horizontal)
                        .tabItem {
                            Label(PageData.debts.title, systemImage: PageData.debts.sytemIcon)
                        }
                    DebtorsView()
                        .padding(.horizontal)
                        .tabItem {
                            Label(PageData.debtors.title, systemImage: PageData.debtors.sytemIcon)
                        }
                    
                    Text("")
                        .tabItem {
                            Label("", systemImage: "")
                        }.disabled(true)
                    
                    HistoryView()
                        .tabItem {
                            Label(PageData.history.title, systemImage: PageData.history.sytemIcon)
                        }
                    SettingsView()
                        .tabItem {
                            Label(PageData.settings.title, systemImage: PageData.settings.sytemIcon)
                           
                        }
                }
                .accentColor(AppSettings.accentColor)
                
                VStack {
                    Spacer()
                    
                    Button(action: {
                        sheet = .addDebtViewPresent
                    }, label: {
                        TabBarAddButton(geometry: geometry)
                    })
                    .frame(width: geometry.size.width/3.5, height: 80, alignment: .center)
                    .background(Color.clear)
                    
                }
                
            }
        }
        
        .sheet(item: $sheet) { item in
            switch item {
            case .addDebtViewPresent:
                AddDebtView()
                    .environmentObject(addDebtVM)
                    .environmentObject(currencyListVM)
                    .environmentObject(debtorsDebt)
            }
        }
        

    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
            .environmentObject(DebtorsDebtsViewModel())
            .environmentObject(AddDebtViewModel())
            .environmentObject(CurrencyListViewModel())
            .environmentObject(CurrencyListViewModel())
        /*.environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)*/
    }
}
