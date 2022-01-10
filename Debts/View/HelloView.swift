//
//  HelloView.swift
//  Debts
//
//  Created by Sergei Volkov on 05.01.2022.
//

import SwiftUI

struct HelloView: View {
    @AppStorage(UDKeys.showHelloView) var showHelloView: Bool = false
    @StateObject private var migrationMan = MigrationManager()
    
    
    let helloVM: HelloViewModel
    
    var body: some View {
        TabView {
            ForEach(helloVM.hello) { item in
                ScrollView {
                    VStack {
                        if let image = item.image {
                            Image(image)
                                .resizable()
                                .scaledToFit()
                                .frame(height: UIScreen.main.bounds.height / 2)
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                        }
                        if let systemImage = item.systemImage {
                            Image(systemName: systemImage)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 180, height: 180)
                                .symbolRenderingMode(.hierarchical)
                                .foregroundStyle(.gray)
                                .scaledToFit()
                                .padding(40)
                        }
                        VStack(alignment: .leading, spacing: 10) {
                            Text(item.title)
                                .font(.system(size: 28, weight: .bold, design: .default))
                            Text(item.text)
                                .font(.title3)
                        }
                        if let _ = item.systemImage {
                            VStack(spacing: 20) {
                                Button(role: .cancel) {
                                    withAnimation {
                                        showHelloView = true
                                        SettingsViewModel.shared.helloViewIsActive = false
                                    }
                                } label: {
                                    Text(LocalStrings.Views.HelloView.skip)
                                        .frame(width: 200)
                                }
                                .buttonStyle(.bordered)
                                
                                Button {
                                    migrationMan.migrateDebts(debts: helloVM.newDebts, debtsIsClosed: false)
                                    migrationMan.migrateDebts(debts: helloVM.newHistoryDebts, debtsIsClosed: true)
                                    withAnimation {
                                        showHelloView = true
                                        SettingsViewModel.shared.helloViewIsActive = false
                                    }
                                    
                                } label: {
                                    Text(LocalStrings.Views.HelloView.convert)
                                        .frame(width: 200)
                                }
                                .buttonStyle(.borderedProminent)
                            }
                            .controlSize(.large)
                            .padding()
                            
                        } else {
                            EmptyView()
                        }
                        Spacer()
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 50)
                }
            }
        }
        .tabViewStyle(.page)
        .indexViewStyle(.page(backgroundDisplayMode: .always))
        
        .onAppear() {
            helloVM.newDebts = migrationMan.convertDebtModel(debts: migrationMan.LoadOldData())
            helloVM.newHistoryDebts = migrationMan.convertDebtModel(debts: migrationMan.LoadOldHistory())
        }
    }
}
