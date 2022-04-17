//
//  ContactController.swift
//  Debts
//
//  Created by Sergei Volkov on 18.04.2021.
//

import SwiftUI
import ContactsUI

protocol EmbeddedContactPickerViewControllerDelegate: AnyObject {
    func embeddedContactPickerViewControllerDidCancel(_ viewController: EmbeddedContactPickerViewController)
    func embeddedContactPickerViewController(_ viewController: EmbeddedContactPickerViewController, didSelect contact: CNContact)
}

final class EmbeddedContactPickerViewController: UIViewController, CNContactPickerDelegate {
    
    @AppStorage(UDKeys.colorScheme) private var selectedScheme: String = "system"
    
    weak var delegate: EmbeddedContactPickerViewControllerDelegate?

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.open(animated: animated)
    }

    private func open(animated: Bool) {
        let viewController = CNContactPickerViewController()
        viewController.delegate = self
        viewController.overrideUserInterfaceStyle = selectedScheme == "light" ? .light : selectedScheme == "dark" ? .dark : .light
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
            
            if let imageData = contact.imageData {
                guard let image = UIImage(data: imageData) else {return}
                
                AddDebtViewModel.shared.showActivity = true
                
                guard let resizedImage = image.resized(toWidth: 128) else {
                    AddDebtViewModel.shared.showActivity = false
                    return
                }
                guard let compressedImage = resizedImage.jpegData(compressionQuality: 0.5) else {
                    AddDebtViewModel.shared.showActivity = false
                    return
                }
//                print(compressedImage.description)
                
                DispatchQueue.main.async {
                    AddDebtViewModel.shared.image = compressedImage
                    AddDebtViewModel.shared.showActivity = false
                    HistoryViewModel.shared.refreshedID = UUID()
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
