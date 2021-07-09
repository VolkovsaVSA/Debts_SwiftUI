//
//  TwoButtonActionCancel.swift
//  Debts
//
//  Created by Sergei Volkov on 06.07.2021.
//

import SwiftUI

struct TwoButtonActionCancel: ViewModifier {
    
    let title: String
    let text: String
    let primaryActionTitle: String
    let primaryAction: ()->()
    let cancelActionTitle: String
    let cancelAction: ()->()
    @State var alertType: AlertType?
    
    func body(content: Content) -> some View {
        content
            .alert(item: $alertType) { alert in
                switch alert {
                case .twoButtonActionCancel:
                    return Alert(title: Text(title),
                                 message: Text(text),
                                 primaryButton: .default(Text(primaryActionTitle), action: primaryAction),
                                 secondaryButton: .cancel(Text(cancelActionTitle), action: cancelAction)
                    )
                default:
                    return Alert(title: Text(""))
                }
            }
    }
}
