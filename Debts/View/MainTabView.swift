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
    
    @EnvironmentObject private var addDebtVM: AddDebtViewModel
    @EnvironmentObject private var currencyListVM: CurrencyViewModel
    @EnvironmentObject private var debtorsDebt: DebtsViewModel
    @EnvironmentObject private var settingsVM: SettingsViewModel
    
    @State private var sheet: SheetType?

    var body: some View {
        
        GeometryReader { geometry in
            ZStack {
                TabView {
                    
                    DebtsView(selectedSortObject: SortObject())
                        .tabItem {
                            Label(PageData.debts.title, systemImage: PageData.debts.sytemIcon)
                        }
                    DebtorsView(selectedSortDebtorsObject: SortDebtorsObject.shared)
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
                            .frame(width: GraphicSettings.calcRotateWidth(geometry: geometry)/3.5, height: 70, alignment: .center)
                            
                            .background(Color.white.opacity(0))
                    })
//                        .buttonStyle(.plain)
                }
                .ignoresSafeArea(.keyboard, edges: .all)
                
            }
        }
        
        .onAppear {
            
            UITabBar.appearance().backgroundColor = .systemGroupedBackground
            
            if !UserDefaults.standard.bool(forKey: UDKeys.notFirstRun) {
                NotificationManager.requestAuthorization { granted in
                    DispatchQueue.main.async {
                        settingsVM.sendNotifications = granted
                        UserDefaults.standard.set(true, forKey: UDKeys.notFirstRun)
                    }
                    
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
            default: EmptyView()
            }
        }
        

    }
    
    private func calcRotateWidth(geometry: GeometryProxy) -> CGFloat {
        return geometry.size.height > geometry.size.width ? geometry.size.width : geometry.size.width
    }
}
