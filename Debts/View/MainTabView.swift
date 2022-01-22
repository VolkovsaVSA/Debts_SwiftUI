//
//  ContentView.swift
//  Debts
//
//  Created by Sergei Volkov on 01.03.2021.
//

import SwiftUI
import CoreData
import AppTrackingTransparency

struct MainTabView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.colorScheme) var colorScheme
    @AppStorage(UDKeys.showHelloView) var showHelloView: Bool = false
    
    @EnvironmentObject private var addDebtVM: AddDebtViewModel
    @EnvironmentObject private var currencyListVM: CurrencyViewModel
    @EnvironmentObject private var debtorsDebt: DebtsViewModel
    @EnvironmentObject private var settingsVM: SettingsViewModel
    @EnvironmentObject private var adsVM: AdsViewModel
    
    @State private var sheet: SheetType?
//    @State private var buttonSize: CGFloat = 60
   
    var body: some View {
        
        GeometryReader { geometry in
            ZStack {
                TabView {
                    
                    DebtsView(selectedSortObject: SortObject())
                        .navigationViewStyle(.stack)
                        .tabItem {
                            Label(PageData.debts.title, systemImage: PageData.debts.sytemIcon)
                        }
                        
                    DebtorsView(selectedSortDebtorsObject: SortDebtorsObject.shared)
                        .navigationViewStyle(.stack)
                        .tabItem {
                            Label(PageData.debtors.title, systemImage: PageData.debtors.sytemIcon)
                        }
                    
                    Text("")
                        .tabItem {
                            Label("", systemImage: "")
                        }.disabled(true)
                    
                    HistoryView()
                        .navigationViewStyle(.stack)
                        .tabItem {
                            Label(PageData.history.title, systemImage: PageData.history.sytemIcon)
                        }
                        .onAppear {
                            adsVM.showInterstitial = true
                        }
                    SettingsView()
                        .navigationViewStyle(.stack)
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
                        TabBarAddButton(size: 50)
                            .frame(width: 90, height: 70, alignment: .center)
                            .background(Color.white.opacity(0))
                    })
                }
                .ignoresSafeArea(.keyboard, edges: .all)

                if !showHelloView {
                    HelloView(helloVM: HelloViewModel(colorScheme: colorScheme))
                        .background(Color(UIColor.systemBackground))
                }
                
                
            }
        }
        .onChange(of: showHelloView, perform: { newValue in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                ATTrackingManager.requestTrackingAuthorization { _ in }
            }
        })
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
    
//    private func calcRotateWidth(geometry: GeometryProxy) -> CGFloat {
//        return geometry.size.height > geometry.size.width ? geometry.size.width : geometry.size.width
//    }
}
