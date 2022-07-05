//
//  ToDoListViewController.swift
//  ToDoApp
//
//  Created by Danielle Nozaki Ogawa on 2022/06/25.
//

import UIKit

class ToDoListViewController: UITableViewController {
    
    var viewModel: ViewModelTasks?
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.loadTasks()
        searchBar.delegate = self
        viewModel?.delegate = self
    }
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfTasks() ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = viewModel?.getTask(row: indexPath.row)
        
        cell.textLabel?.text = item?.task
            
        
        cell.accessoryType = item!.done ? .checkmark : .none
        
        return cell
    }
    
    //MARK: - tableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let task = viewModel?.getTask(row: indexPath.row)
        task?.done = !(task?.done ?? false)
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    @IBAction func addAction(_ sender: Any) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new to do item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { action in
            
            self.viewModel?.addTask(title: textField.text)
            
            self.tableView.reloadData()
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel?.removeTask(at: indexPath.row)
            tableView.reloadData()
        }
    }
    
}

// MARK: - Search Bar
extension ToDoListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel?.search(searchBar: searchBar.text)

    }
}

extension ToDoListViewController: ViewModelDelegate {
    
    func atualizaTableView() {
        tableView.reloadData()
    }
    
}
