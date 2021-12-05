//
//  ContactController.swift
//  Debts
//
//  Created by Sergei Volkov on 18.04.2021.
//

import SwiftUI
import ContactsUI


//struct ContactPicker {
//    
//}



//struct ContactPickerButton: UIViewRepresentable {
//
//    func makeUIView(context: UIViewRepresentableContext<ContactPickerButton>) -> UIButton {
//        let button = UIButton()
//        let icon = "person.crop.circle.badge.plus"
//        button.setImage(UIImage(systemName: icon), for: .normal)
//        button.addTarget(context.coordinator, action: #selector(context.coordinator.pressed(_:)), for: .touchUpInside)
//        context.coordinator.button = button
//        return button
//    }
//    func updateUIView(_ uiView: UIButton, context: UIViewRepresentableContext<ContactPickerButton>) {
//    }
//    
//    func makeCoordinator() -> Coordinator {
//        Coordinator(self)
//    }
//    
//    
//    class Coordinator: NSObject, CNContactViewControllerDelegate, CNContactPickerDelegate {
//        var button: UIButton?
//        var parent: ContactPickerButton
//        init(_ contactButton: ContactPickerButton) {
//            self.parent = contactButton
//        }
//        
//        func contactPicker (_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
//            print(contact)
//        }
//        
//        @objc func pressed(_ sender: UIButton) {
//            let controller = CNContactPickerViewController()
//            controller.delegate = self
//            controller.definesPresentationContext = true
////            sender.window?.rootViewController?.present(controller, animated: true)
//            UIApplication.shared.windows.first?.rootViewController?.present(controller, animated: true)
////            UIApplication.shared.windows.first?.rootViewController?.children.first?.present(controller, animated: true)
//            
//            
//            
//            
//        }
//    }
//    
//}



protocol EmbeddedContactPickerViewControllerDelegate: AnyObject {
    func embeddedContactPickerViewControllerDidCancel(_ viewController: EmbeddedContactPickerViewController)
    func embeddedContactPickerViewController(_ viewController: EmbeddedContactPickerViewController, didSelect contact: CNContact)
}

class EmbeddedContactPickerViewController: UIViewController, CNContactPickerDelegate {
    
    weak var delegate: EmbeddedContactPickerViewControllerDelegate?

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.open(animated: animated)
    }

    private func open(animated: Bool) {
        let viewController = CNContactPickerViewController()
        viewController.delegate = self
        viewController.overrideUserInterfaceStyle = .dark
        self.present(viewController, animated: false)
    }

    func contactPickerDidCancel(_ picker: CNContactPickerViewController) {
        self.dismiss(animated: false) {
            self.delegate?.embeddedContactPickerViewControllerDidCancel(self)
        }
    }

    func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
        self.dismiss(animated: false) {
            self.delegate?.embeddedContactPickerViewController(self, didSelect: contact)
        }
    }
}
struct EmbeddedContactPicker: UIViewControllerRepresentable {
    typealias UIViewControllerType = EmbeddedContactPickerViewController
    
    @Environment(\.presentationMode) var presentationMode

    final class Coordinator: NSObject, EmbeddedContactPickerViewControllerDelegate {
        func embeddedContactPickerViewController(_ viewController: EmbeddedContactPickerViewController, didSelect contact: CNContact) {
            
            let debtors = CDStack.shared.fetchDebtors()
            var debtorsMatching = Set<DebtorCD>()
         
            debtors.forEach { debtor in
                if let debtorPone = debtor.phone,
                   contact.phoneNumbers.count != 0
                {
                    if (debtor.fullName == contact.givenName + " " + contact.familyName) || (debtorPone == contact.phoneNumbers[0].value.stringValue) {
                        debtorsMatching.insert(debtor)
                    }
                } else {
                    if (debtor.fullName == contact.givenName + " " + contact.familyName) {
                        debtorsMatching.insert(debtor)
                    }
                }
                
            }
            
            AddDebtViewModel.shared.firstName = contact.givenName
            AddDebtViewModel.shared.familyName = contact.familyName
            AddDebtViewModel.shared.phone = contact.phoneNumbers.count != 0 ? contact.phoneNumbers[0].value.stringValue : ""
            AddDebtViewModel.shared.email = contact.emailAddresses.first?.value.description ?? ""
            if let image = contact.imageData {
                if let userImage =  UIImage(data: image) {
                    AddDebtViewModel.shared.image = userImage
                }
            }
            
            if debtorsMatching.isEmpty {
                AddDebtViewModel.shared.debtorsMatching.removeAll()
            } else {
                AddDebtViewModel.shared.debtorsMatching = debtorsMatching
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                    withAnimation {
                        AddDebtViewModel.shared.showDebtorWarning = true
                    }
                }
            }
             
            viewController.dismiss(animated: false)
        }

        func embeddedContactPickerViewControllerDidCancel(_ viewController: EmbeddedContactPickerViewController) {
            viewController.dismiss(animated: false)
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator()
    }

    func makeUIViewController(context: UIViewControllerRepresentableContext<EmbeddedContactPicker>) -> EmbeddedContactPicker.UIViewControllerType {
        let result = EmbeddedContactPicker.UIViewControllerType()
        result.delegate = context.coordinator
        return result
    }

    func updateUIViewController(_ uiViewController: EmbeddedContactPicker.UIViewControllerType, context: UIViewControllerRepresentableContext<EmbeddedContactPicker>) { }

}
