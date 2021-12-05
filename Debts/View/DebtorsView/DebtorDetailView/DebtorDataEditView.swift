//
//  DebtorDataEditView.swift
//  Debts
//
//  Created by Sergei Volkov on 01.12.2021.
//

import SwiftUI

struct DebtorDataEditView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @ObservedObject var debtor: DebtorCD
    let handler: ()->()
    
    private enum Field: Hashable {
        case firstName
        case familyName
        case phone
        case email
    }
    @FocusState private var focusedField: Field?
    @State private var firstName = ""
    @State private var familyName = ""
    @State private var phone = ""
    @State private var email = ""
    @State private var showWarning = false
    
    private let textWidth: CGFloat = 120

    var body: some View {
        
        VStack {
            
            Button {
            
            } label: {
                PersonImage(size: 100)
            }
            
            Group {
                TextField("First name", text: $firstName, prompt: Text("First name"))
                    .focused($focusedField, equals: .firstName)
                    .textContentType(.givenName)
                    .submitLabel(.next)
                TextField("Family name", text: $familyName, prompt: Text("Family name"))
                    .focused($focusedField, equals: .familyName)
                    .textContentType(.familyName)
                    .submitLabel(.next)
                TextField("Phone", text: $phone, prompt: Text("Phone"))
                    .focused($focusedField, equals: .phone)
                    .textContentType(.telephoneNumber)
                    .submitLabel(.next)
                TextField("Email", text: $email, prompt: Text("Email"))
                    .focused($focusedField, equals: .email)
                    .textContentType(.emailAddress)
                    .submitLabel(.done)
            }
            .disableAutocorrection(true)
            .modifier(CellModifire(frameMinHeight: 14))
//            .textFieldStyle(.roundedBorder)
            .onSubmit {
                switch focusedField {
                    case .firstName:
                        focusedField = .familyName
                    case .familyName:
                        focusedField = .phone
                    case .phone:
                        focusedField = .email
                    default:
                        break
                }
            }

            Button {
                if firstName == "" {
                    showWarning = true
                } else {
                    debtor.firstName = firstName
                    debtor.familyName = (familyName == "") ? nil : familyName
                    debtor.phone = (phone == "") ? nil : phone
                    debtor.email = (email == "") ? nil : email
                    
                    CDStack.shared.saveContext(context: viewContext)
                    handler()
                }
            } label: {
                Text("Save")
                    .frame(width: UIScreen.main.bounds.width - 56)
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.regular)
            .tint(AppSettings.accentColor)
            .padding(.vertical, 20)
        }
        .padding(.horizontal)
        
        .alert("Atention", isPresented: $showWarning, actions: {
            
        }, message: {
            Text("You must enter first name!")
        })
        
        .onAppear {
            firstName = debtor.firstName
            if let unwrapFamilyName = debtor.familyName {
                familyName = unwrapFamilyName
            }
            if let unwrapPhone = debtor.phone {
                phone = unwrapPhone
            }
            if let unwrapEmail = debtor.email {
                email = unwrapEmail
            }
            
            focusedField = .firstName
        }
        
       
    }
}
