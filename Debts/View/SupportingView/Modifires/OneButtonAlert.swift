//
//  OneButtonAlert.swift
//  Debts
//
//  Created by Sergei Volkov on 16.05.2021.
//

import SwiftUI

struct OneButtonAlert: ViewModifier {
    
    let title: String
    let text: String
    @State var alertType: AlertType?
    
    func body(content: Content) -> some View {
        content
            .alert(item: $alertType) { alert in
                switch alert {
                case .oneButtonInfo:
                    return Alert(
                        title: Text(title),
                        message: Text(text),
                        dismissButton: .cancel(Text(LocalStrings.Button.ok))
                    )
                default:
                    return Alert(title: Text(""))
                }
            }
    }
}
