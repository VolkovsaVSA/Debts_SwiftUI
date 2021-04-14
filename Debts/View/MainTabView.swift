//
//  ContentView.swift
//  Debts
//
//  Created by Sergei Volkov on 01.03.2021.
//

import SwiftUI
import CoreData

struct MainTabView: View {
//    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var sheet: SheetType?
    
    //    @FetchRequest(
    //        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
    //        animation: .default)
    //    private var items: FetchedResults<Item>
    
    var body: some View {
        
        GeometryReader { geometry in
            ZStack {
                TabView {
                    DebtsView()
//                            .padding(.horizontal)
                        .tabItem {
                            Label(PageData.debts.title, systemImage: PageData.debts.sytemIcon)
                        }
                    DebtorsView()
                        .tabItem {
                            Label(PageData.debtors.title, systemImage: PageData.debtors.sytemIcon)
                        }
                    
                    Text("")
                        .tabItem {
                            Label("", systemImage: "")
                        }
                    
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
                    .frame(width: geometry.size.width/4, height: 80, alignment: .center)
                    
                }
                
            }
        }
        
        .sheet(item: $sheet) { item in
            switch item {
            case .addDebtViewPresent:
                AddDebtView()
            }
        }

    }
    
    //    private func addItem() {
    //        withAnimation {
    //            let newItem = Item(context: viewContext)
    //            newItem.timestamp = Date()
    //
    //            do {
    //                try viewContext.save()
    //            } catch {
    //                // Replace this implementation with code to handle the error appropriately.
    //                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
    //                let nsError = error as NSError
    //                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
    //            }
    //        }
    //    }
    
    //    private func deleteItems(offsets: IndexSet) {
    //        withAnimation {
    //            offsets.map { items[$0] }.forEach(viewContext.delete)
    //
    //            do {
    //                try viewContext.save()
    //            } catch {
    //                // Replace this implementation with code to handle the error appropriately.
    //                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
    //                let nsError = error as NSError
    //                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
    //            }
    //        }
    //    }
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
