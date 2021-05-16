//
//  AddItemViewController.swift
//  ToDoList
//
//  Created by Amin  on 5/16/21.
//  Copyright © 2021 MAC. All rights reserved.
//

import UIKit

protocol AddItemViewControllerDelegate: AnyObject {
    
    func addItemViewControllerDidCancel(_ controller: AddItemViewController)
    
    func addItemViewController(_ controller: AddItemViewController, didFinishAdding item: Item)
    
}

class AddItemViewController: UITableViewController {
    
    weak var delegate: AddItemViewControllerDelegate?
    
    // Outlets
    @IBOutlet weak var textField: UITextField!
    
    // Actions
    @IBAction func cancelButton(_ sender: Any) {
        
        delegate?.addItemViewControllerDidCancel(self)
    }
    
    
    @IBAction func doneButton(_ sender: Any) {
        
        let item = Item()
        item.title = textField.text
        
        delegate?.addItemViewController(self, didFinishAdding: item)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.largeTitleDisplayMode = .never        
        tableView.tableFooterView = UIView()
        
        textField.delegate = self

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        textField.becomeFirstResponder()
    }

}

extension AddItemViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        doneButton(textField.returnKeyType)
        return true
    }
}
