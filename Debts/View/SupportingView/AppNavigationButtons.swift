//
//  AppNavigationButtons.swift
//  Debts
//
//  Created by Sergei Volkov on 06.05.2021.
//

import SwiftUI

struct CancelSaveNavBar: ViewModifier {
    
    let navTitle: String
    let cancelAction: ()->()
    let saveAction: ()->()
    let noCancelButton: Bool
    
    func body(content: Content) -> some View {
        
        if noCancelButton {
            return
                AnyView(content
                .navigationBarItems(trailing: saveButton())
                .navigationTitle(navTitle)
            )
        } else {
            return
                AnyView(content
                .navigationBarItems(leading: cancelButton(),
                                    trailing: saveButton())
                .navigationTitle(navTitle)
            )
        }

    }
    
    
    private func saveButton() -> AnyView {
        return AnyView(
            Button(action: {
                saveAction()
            }, label: {
                Text(LocalStrings.Button.save)
                    .frame(width: 100)
                    .foregroundColor(.white)
                    .padding(4)
                    .background(AppSettings.accentColor)
                    .cornerRadius(8)
            })
        )
    }
    private func cancelButton() -> AnyView {
        return AnyView(
            Button(action: {
                cancelAction()
            }, label: {
                Text(LocalStrings.Button.cancel)
                    .frame(width: 100)
                    .foregroundColor(.white)
                    .padding(4)
                    .background(Color(UIColor.systemGray2))
                    .cornerRadius(8)
            })
        )
    }
}
