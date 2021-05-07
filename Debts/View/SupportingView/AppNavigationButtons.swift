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
    
    func body(content: Content) -> some View {
        content
            .navigationBarItems(leading:
                                    Button(action: {
                                        cancelAction()
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
                                        saveAction()
                                    }, label: {
                                        Text("SAVE")
                                            .frame(width: 80)
                                            .foregroundColor(.white)
                                            .padding(4)
                                            .background(AppSettings.accentColor)
                                            .cornerRadius(8)
                                    })
            )
            .navigationTitle(navTitle)
    }
}
