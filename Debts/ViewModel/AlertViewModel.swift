//
//  AlertViewModel.swift
//  Debts
//
//  Created by Sergei Volkov on 06.07.2021.
//

import SwiftUI

//class AlertViewModel: ObservableObject {
//
//    static let shared = AlertViewModel()
//    
//    var title = ""
//    var text = ""
//    @Published var alertType: AlertType?
//    
//    struct OneButtonAlert: ViewModifier {
//        
//        let title = AlertViewModel.shared.title
//        let text = AlertViewModel.shared.text
//        @State var alertType = AlertViewModel.shared.alertType
//        
//        func body(content: Content) -> some View {
//            content
//                .alert(item: $alertType) { alert in
//                    switch alert {
//                    case .oneButtonInfo:
//                        return Alert(
//                            title: Text(title),
//                            message: Text(text),
//                            dismissButton: .cancel(Text("OK"))
//                        )
//                    default:
//                        return Alert(title: Text(""))
//                    }
//                }
//        }
//    }
//    
//    struct TwoButtonActionCancel: ViewModifier {
//        
//        let title = AlertViewModel.shared.title
//        let text = AlertViewModel.shared.text
//        let primaryActionTitle: String
//        let primaryAction: ()->()
//        let cancelActionTitle: String
//        let cancelAction: ()->()
//        @State var alertType: AlertType?
//        
//        func body(content: Content) -> some View {
//            content
//                .alert(item: $alertType) { alert in
//                    switch alert {
//                    case .twoButtonActionCancel:
//                        return Alert(title: Text(title),
//                                     message: Text(text),
//                                     primaryButton: .default(Text(primaryActionTitle), action: primaryAction),
//                                     secondaryButton: .cancel(Text(cancelActionTitle), action: cancelAction)
//                        )
//                    default:
//                        return Alert(title: Text(""))
//                    }
//                }
//        }
//    }
//}


