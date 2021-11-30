//
//  DebtorInfoView.swift
//  Debts
//
//  Created by Sergei Volkov on 14.07.2021.
//

import SwiftUI

struct DebtorInfoSectionView: View {
    
    @EnvironmentObject var addDebtVM: AddDebtViewModel
    
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
                    
                    if let userImage = addDebtVM.image {
                        Image(uiImage: userImage)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100, alignment: .center)
                            .foregroundColor(.gray)
                    } else {
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100, alignment: .center)
                            .foregroundColor(.gray)
                    }
                    
                    Spacer()
                    VStack(alignment: .trailing, spacing: 10) {
                        AddDebtorInfoButton(title: String(localized: "From contacts"),
                                            buttonColor: AppSettings.accentColor,
                                            titleColor: .white) {
                            addDebtVM.sheetType = .contactPicker
                        }
                        AddDebtorInfoButton(title: String(localized: "From debtors"),
                                            buttonColor: AppSettings.accentColor,
                                            titleColor: .white) {
                            addDebtVM.sheetType = .debtorsList
                        }
                    }
                }
                Group {
                    TextField("First name", text: $addDebtVM.firstName)
                        
                    TextField("Family name", text: $addDebtVM.familyName)
                       
                    TextField("Phone", text: $addDebtVM.phone)
                        .keyboardType(.phonePad)
                    TextField("Email", text: $addDebtVM.email)
                        .keyboardType(.emailAddress)
                }
                .padding(.top, 4)
                .padding(.bottom, 6)
            }
        }
        .listRowSeparator(.hidden)
        
    }
}

