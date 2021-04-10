//
//  AddDebtView.swift
//  Debts
//
//  Created by Sergei Volkov on 09.04.2021.
//

import SwiftUI

struct AddDebtView: View {
    
    @ObservedObject var addDebtVM = AddDebtViewModel()

    
    var body: some View {
        
        NavigationView {
            
            ZStack {

                List {
                    Section(header: addDebtVM.localDebtorStatus == 0 ? Text(DebtorStatus.debtorLocalString): Text(DebtorStatus.creditorLocalString)) {
                        Picker("", selection: $addDebtVM.localDebtorStatus) {
                            Text(DebtorStatus.debtorLocalString).tag(0)
                            Text(DebtorStatus.creditorLocalString).tag(1)
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        VStack {
                            HStack {
                                Spacer()
                                Image(systemName: "person.crop.circle.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100, height: 100, alignment: .center)
                                    .foregroundColor(.gray)
                                Spacer()
                                VStack(alignment: .trailing, spacing: 10) {
                                    AddDebtorInfoButton(title: "From contacts",
                                                        buttonColor: Color(UIColor.systemGray),
                                                        titleColor: .white) {
                                        
                                    }
                                    AddDebtorInfoButton(title: "From debtors",
                                                        buttonColor: Color(UIColor.systemGray),
                                                        titleColor: .white) {
                                        
                                    }

                                }

                                
                            }
                            Group {
                                TextField("First name", text: $addDebtVM.firstName)
                                TextField("Family name", text: $addDebtVM.firstName)
                                TextField("Phone", text: $addDebtVM.phone)
                                TextField("Email", text: $addDebtVM.email)
                            }
                            .padding(.top, 4)
                            .padding(.bottom, 6)
                            
                        }
                    }
                    
                    Section(header: Text("Debt")) {
                        HStack {
                            TextField("Debt amount", text: $addDebtVM.firstName)
                            Text("RUB")
                        }
                        DatePicker("Start date", selection: $addDebtVM.startDate)
                        DatePicker("End date", selection: $addDebtVM.endDate)
                        HStack {
                            TextField("Percent", text: $addDebtVM.percent)
                            Picker("%", selection: $addDebtVM.selectedPercentType) {
                                ForEach(PercentType.allCases, id: \.self) { type in
                                    Text(PercentType.percentTypeConvert(type: type))
                                }
                            }.lineLimit(1)
                        }
                        TextField("Comment", text: $addDebtVM.comment)
                    }
                }
                .listStyle(InsetGroupedListStyle())
                
                
                
//                VStack {
//                    Spacer()
//                    HStack {
//                        Spacer()
//                        Button(action: {
//
//                        }, label: {
//                            Text("Cancel")
//                                .frame(width: 100)
//                                .foregroundColor(.white)
//                                .padding(8)
//                                .background(Color(UIColor.systemGray2))
//                                .cornerRadius(10)
//                        })
//                        Spacer()
//                        Button(action: {
//
//                        }, label: {
//                            Text("SAVE")
//                                .fontWeight(.bold)
//                                .frame(width: 100)
//                                .foregroundColor(.white)
//                                .padding(8)
//                                .background(Color.green)
//                                .cornerRadius(10)
//                        })
//                        Spacer()
//                    }.offset(y: -16)
//                }.edgesIgnoringSafeArea(.bottom)
                
                
            }
            
            .navigationBarItems(leading:
                                    Button(action: {
                                        
                                    }, label: {
                                        Text("Cancel")
                                            .frame(width: 80)
                                            .foregroundColor(.white)
                                            .padding(4)
                                            .background(Color(UIColor.systemGray2))
                                            .cornerRadius(8)
                                    }),
                                
                                
                                trailing:
                                    Button(action: {
                                        
                                    }, label: {
                                        Text("SAVE")
                                            .frame(width: 80)
                                            .foregroundColor(.white)
                                            .padding(4)
                                            .background(Color(UIColor.systemGreen))
                                            .cornerRadius(8)
                                    })
            )

            .navigationTitle(NSLocalizedString("Add debt", comment: "navTitle"))
        }
        
    }
}

struct AddDebtView_Previews: PreviewProvider {
    static var previews: some View {
        AddDebtView()
    }
}
