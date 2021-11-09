//
//  AddDebtorView.swift
//  Debts
//
//  Created by Sergei Volkov on 08.11.2021.
//

import SwiftUI

//struct AddDebtorView: View {
//    
//    @EnvironmentObject var addDebtVM: AddDebtViewModel
//    @Environment(\.dismiss) var dismiss
//    
//    var body: some View {
//        
//        NavigationView {
//            VStack {
//                HStack {
//                    Spacer()
//                    
//                    if let userImage = addDebtVM.image {
//                        Image(uiImage: userImage)
//                            .resizable()
//                            .scaledToFit()
//                            .frame(width: 100, height: 100, alignment: .center)
//                            .foregroundColor(.gray)
//                    } else {
//                        Image(systemName: "person.crop.circle.fill")
//                            .resizable()
//                            .scaledToFit()
//                            .frame(width: 100, height: 100, alignment: .center)
//                            .foregroundColor(.gray)
//                    }
//                    
//                    Spacer()
//                    VStack(alignment: .trailing, spacing: 10) {
//                        AddDebtorInfoButton(title: String(localized: "From contacts"),
//                                            buttonColor: AppSettings.accentColor,
//                                            titleColor: .white) {
//                            
//                            addDebtVM.sheetType = .contactPicker
//                        }
//                    }
//                }
//                .padding(.bottom)
//                Divider()
//                VStack(alignment: .leading, spacing: 16) {
//                    TextField("First name", text: $addDebtVM.firstName)
//                        
//                    TextField("Family name", text: $addDebtVM.familyName)
//                       
//                    TextField("Phone", text: $addDebtVM.phone)
//                        .keyboardType(.phonePad)
//                    TextField("Email", text: $addDebtVM.email)
//                        .keyboardType(.emailAddress)
//                }
//                Divider()
//                Spacer()
//            }
//            .padding()
//
//            
//            .sheet(item: $addDebtVM.sheetType) { sheet in
//                switch sheet {
//                case .contactPicker:
//                    EmbeddedContactPicker()
//                default: EmptyView()
//                }
//            }
//            .toolbar {
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    Button {
//                        addDebtVM.resetData()
//                        dismiss()
//                    } label: {
//                        Image(systemName: "multiply.circle.fill")
//                    }.accentColor(AppSettings.accentColor)
//                }
//            }
//            .navigationBarTitle(Text("Add debtor"))
//        }
//        
//    }
//}
