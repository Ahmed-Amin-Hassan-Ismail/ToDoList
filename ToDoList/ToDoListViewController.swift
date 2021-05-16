//
//  ViewController.swift
//  ToDoList
//
//  Created by Amin  on 5/16/21.
//  Copyright © 2021 MAC. All rights reserved.
//

import UIKit

class ToDoListViewController: UIViewController {
    
    var items: [Item] = []
    
    // Outlets
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        // Custome Navigation Controller
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.backgroundImage(for: UIBarPosition.topAttached, barMetrics: .default)
        navigationController?.navigationBar.backgroundImage(for: UIBarMetrics.default)
        navigationController?.navigationBar.largeTitleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.red,
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 40)]
        
        // confirm the delegate
        tableView.dataSource = self
        tableView.delegate = self
        
        // Hide the emplty rows
        tableView.tableFooterView = UIView()
        
        // To Add Default Row
        if items.count == 0 {
            forFirstTime()
        }
        
    }
    
    // Private Function
    private func configureText(cell: UITableViewCell, with item: Item) {
        cell.textLabel?.text = item.title
    }
    
    private func configureCheckmark(cell: UITableViewCell, with item: Item) {
        if item.isChecked {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
    }
    
    private func forFirstTime() {
        if items.count == 0 {
            let item = Item()
            item.title = "Hello World 👽"
            item.isChecked = true
            items.append(item)
        }
    }
    
    //MARK:- Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == " addItem" {
            let controller = segue.destination as! AddItemViewController
            controller.delegate = self
        }
    }

}

//MARK:- TableViewDataSource
extension ToDoListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "dataCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        // cell Configure...
        let item = items[indexPath.row]
        configureText(cell: cell, with: item)
        configureCheckmark(cell: cell, with: item)
                
        return cell
    }
}

extension ToDoListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let cell = tableView.cellForRow(at: indexPath) {
            let item = items[indexPath.row]
            item.changeChecked()
            configureCheckmark(cell: cell, with: item)
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        // Delete Action
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (_, _, completionHandler) in
            self.items.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            completionHandler(true)
        }
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [deleteAction])
        return swipeConfiguration
    }
}


// MARK:- AddItemViewControllerDelegate
extension ToDoListViewController: AddItemViewControllerDelegate {
    
    func addItemViewControllerDidCancel(_ controller: AddItemViewController) {
        navigationController?.popViewController(animated: true)
    }
    
    func addItemViewController(_ controller: AddItemViewController, didFinishAdding item: Item) {
        
        let newIndex = items.count
        items.append(item)
        let indexPath = IndexPath(row: newIndex, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
        tableView.reloadData()
        navigationController?.popViewController(animated: true)
    }
    
}

