//
//  DebtorDataEditView.swift
//  Debts
//
//  Created by Sergei Volkov on 01.12.2021.
//

import SwiftUI

struct DebtorDataEditView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject private var editDebtVM = EditDebtorDataViewModel.shared
    @ObservedObject var debtor: DebtorCD
    @Binding var showActivityIndicator: Bool
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
    @State private var warningText = ""
    @State private var image: Data? = nil
    private let textWidth: CGFloat = 120
    
    @State private var showingImagePicker = false
//    @Binding var showActivityIndicator: Bool

    var body: some View {
        
        VStack(spacing: 4) {
            
            Button {
                showingImagePicker = true
            } label: {
                PersonImage(size: 90, image: image)
            }
            .id(editDebtVM.refreshID)
            .padding(4)
            
            Button(LocalStrings.Button.resetImage, role: .destructive) {
                image = nil
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.mini)
            .background(.thinMaterial)
            .padding(.bottom, 4)
            
            Group {
                TextField(LocalStrings.Debtor.Attributes.firstName, text: $firstName,
                          prompt: Text(LocalStrings.Debtor.Attributes.firstName))
                    .focused($focusedField, equals: .firstName)
                    .textContentType(.givenName)
                    .submitLabel(.next)
                TextField(LocalStrings.Debtor.Attributes.familyName, text: $familyName,
                          prompt: Text(LocalStrings.Debtor.Attributes.familyName))
                    .focused($focusedField, equals: .familyName)
                    .textContentType(.familyName)
                    .submitLabel(.next)
                TextField(LocalStrings.Debtor.Attributes.phone, text: $phone,
                          prompt: Text(LocalStrings.Debtor.Attributes.phone))
                    .focused($focusedField, equals: .phone)
                    .textContentType(.telephoneNumber)
                    .submitLabel(.next)
                TextField(LocalStrings.Debtor.Attributes.email, text: $email,
                          prompt: Text(LocalStrings.Debtor.Attributes.email))
                    .focused($focusedField, equals: .email)
                    .textContentType(.emailAddress)
                    .submitLabel(.done)
            }
            .disableAutocorrection(true)
            .modifier(CellModifire(frameMinHeight: 14, useShadow: true))
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
                    warningText = LocalStrings.Views.DebtorsView.enterTheFirstName
                } else {
                    debtor.firstName = firstName
                    debtor.familyName = (familyName == "") ? nil : familyName
                    debtor.phone = (phone == "") ? nil : phone
                    debtor.email = (email == "") ? nil : email
                    debtor.image = image
                    
                    DispatchQueue.main.async {
                        CDStack.shared.saveContext(context: viewContext)
                        DebtsViewModel.shared.refreshData()
                        handler()
                    }
                }
            } label: {
                Text(LocalStrings.Button.save)
                    .frame(width: UIScreen.main.bounds.width - 56)
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.regular)
            .tint(AppSettings.accentColor)
            .padding(.vertical, 6)
            .shadow(color: .black.opacity(0.8), radius: 6, x: 2, y: 2)
        }
        .padding(.horizontal)
        .alert(LocalStrings.Alert.Title.attention, isPresented: $showWarning, actions: {}, message: {
            Text(warningText)
        })
        
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker(image: $image, showActivity: $showActivityIndicator)
        }
        
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
            image = debtor.image
            focusedField = .firstName
        }
       
    }
}
