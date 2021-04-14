//
//  DebtActionMenu.swift
//  Debts
//
//  Created by Sergei Volkov on 14.04.2021.
//

import SwiftUI

struct DebtActionMenu<Content: View>: View {
    
    var content: Content
    var actionData: [[MenuActionModel]]
    
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
//        .menuStyle(LabelMenu())
        .foregroundColor(Color(UIColor.label))
        
    }
}

struct DebtActionMenu_Previews: PreviewProvider {
    static var previews: some View {
        DebtActionMenu(content: Text("Menu"), actionData: [
            
            [MenuActionModel(title: "star", systemIcon: "star") {},
             MenuActionModel(title: "gear", systemIcon: "gear") {},],
            
            [MenuActionModel(title: "square.and.arrow.up", systemIcon: "square.and.arrow.up") {},
             MenuActionModel(title: "trash", systemIcon: "trash") {},]
            
        ])
    }
}


struct LabelMenu: MenuStyle {
    func makeBody(configuration: Configuration) -> some View {
        Menu(configuration)
            .foregroundColor(Color(UIColor.label))
    }
}



