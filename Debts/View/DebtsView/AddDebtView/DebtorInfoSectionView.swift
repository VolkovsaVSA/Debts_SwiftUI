//
//  DebtorInfoView.swift
//  Debts
//
//  Created by Sergei Volkov on 14.07.2021.
//

import SwiftUI

struct DebtorInfoSectionView: View {
    
    @EnvironmentObject private var addDebtVM: AddDebtViewModel
    @State private var showingImagePicker = false
    
    @Binding var showActivityIndicator: Bool
    
    var body: some View {
        
        Section (header: addDebtVM.localDebtorStatus == 0 ? Text(DebtorStatus.debtorLocalString): Text(DebtorStatus.creditorLocalString)) {
            Picker("", selection: $addDebtVM.localDebtorStatus) {
                Text(DebtorStatus.debtorLocalString).tag(0)
                Text(DebtorStatus.creditorLocalString).tag(1)
            }
            .pickerStyle(SegmentedPickerStyle())
            VStack {
                HStack {
                    Spacer()
                    
                    Button {
                        showingImagePicker = true
                    } label: {
                        PersonImage(size: 80, image: addDebtVM.image)
                            .id(addDebtVM.refreshID)
                            .shadow(color: .black.opacity(0.8), radius: 4, x: 2, y: 2)
                    }
                    .buttonStyle(.plain)
                    
                    Spacer()
                    VStack(alignment: .trailing, spacing: 10) {
                        AddDebtorInfoButton(title: LocalStrings.Views.AddDebtView.fromContacts,
                                            buttonColor: AppSettings.accentColor,
                                            titleColor: .white) {
                            addDebtVM.sheetType = .contactPicker
                        }
                        AddDebtorInfoButton(title: LocalStrings.Views.AddDebtView.fromDebtors,
                                            buttonColor: AppSettings.accentColor,
                                            titleColor: .white) {
                            addDebtVM.sheetType = .debtorsList
                        }
                    }
                }
                Group {
                    TextField(LocalStrings.Debtor.Attributes.firstName, text: $addDebtVM.firstName)
                        
                    TextField(LocalStrings.Debtor.Attributes.familyName, text: $addDebtVM.familyName)
                       
                    TextField(LocalStrings.Debtor.Attributes.phone, text: $addDebtVM.phone)
                        .keyboardType(.phonePad)
                    TextField(LocalStrings.Debtor.Attributes.email, text: $addDebtVM.email)
                        .keyboardType(.emailAddress)
                }
                .padding(.top, 4)
                .padding(.bottom, 6)
            }
        }
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker(image: $addDebtVM.image, showActivity: $showActivityIndicator)
        }
        .listRowSeparator(.hidden)
        
    }
}

