//
//  Item.swift
//  ToDoList
//
//  Created by Amin  on 5/16/21.
//  Copyright © 2021 MAC. All rights reserved.
//

import Foundation


class Item {
    
    var title: String?
    var isChecked: Bool = false
    
    func changeChecked() {
        isChecked = !isChecked
    }
}
