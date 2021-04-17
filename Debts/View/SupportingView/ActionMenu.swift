//
//  DebtActionMenu.swift
//  Debts
//
//  Created by Sergei Volkov on 14.04.2021.
//

import SwiftUI

struct ActionMenu<Content: View>: View {
    
    var content: Content
    var actionData: [[ActionMenuModel]]
    
    var body: some View {
        Menu {
            ForEach(actionData, id:\.self) { section in
                Section {
                    ForEach(section, id:\.self) { item in
                        Button(action: {
                            item.action()
                        }, label: {
                            Label(item.title, systemImage: item.systemIcon)
                        })
                    }
                }
            }
        } label: {
            content
        }
        .foregroundColor(Color(UIColor.label))
        
    }
}

struct DebtActionMenu_Previews: PreviewProvider {
    static var previews: some View {
        ActionMenu(content: Text("Menu"), actionData: [
            
            [ActionMenuModel(title: "star", systemIcon: "star") {},
             ActionMenuModel(title: "gear", systemIcon: "gear") {},],
            
            [ActionMenuModel(title: "square.and.arrow.up", systemIcon: "square.and.arrow.up") {},
             ActionMenuModel(title: "trash", systemIcon: "trash") {},]
            
        ])
    }
}


