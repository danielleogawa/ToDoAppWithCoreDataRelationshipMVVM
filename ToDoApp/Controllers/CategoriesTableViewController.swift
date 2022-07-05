//
//  CategoriesTableViewController.swift
//  ToDoApp
//
//  Created by Danielle Nozaki Ogawa on 2022/07/05.
//

import UIKit

class CategoriesTableViewController: UITableViewController {

    let viewModel = CategoryViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.loadCategories()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let taskVC = segue.destination as? ToDoListViewController {
            let rowSeleted = sender as? Int
            taskVC.viewModel = viewModel.getTasks(row: rowSeleted)
        }
    }
    
    
    @IBAction func addButton(_ sender: Any) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add category", style: .default) { action in
            
            self.viewModel.addNewCategory(categoryName: textField.text)
            
            self.tableView.reloadData()
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "Create new category"
            textField = alertTextField
        }
        
        alert.addAction(action)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
    
    
    // MARK: - Table view data source

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getCategoriesCount()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = viewModel.getCategory(row: indexPath.row).name
        cell.accessoryType = .disclosureIndicator
        return cell
    }
   
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.removeCategory(row: indexPath.row)
            tableView.reloadData()
        }
    }
    
    // MARK: - Table view delegate methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        performSegue(withIdentifier: "goToItens", sender: indexPath.row)
    }
    
}
