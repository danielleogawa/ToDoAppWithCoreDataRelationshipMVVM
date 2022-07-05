//
//  ViewModelTasks.swift
//  ToDoApp
//
//  Created by Danielle Nozaki Ogawa on 2022/07/05.
//

import Foundation
protocol ViewModelDelegate {
    func atualizaTableView()
    
}

class ViewModelTasks {
    var category: Category
    
    init(category: Category){
        self.category = category
    }
    var tasks: [Task] = []
    var service = Service()
    var delegate: ViewModelDelegate?
    
    
    func loadTasks(){
        tasks = category.taskArray
    }
    
    func numberOfTasks() -> Int {
        return tasks.count
    }
    
    func getTask(row: Int) -> Task {
        return tasks[row]
    }
    
    func addTask(title: String?){
        guard let title = title else { return }
        
        service.saveTask(category: category, title: title, done: false)
        
        loadTasks()
    }
    
    func removeTask(at row: Int) {
        let task = tasks[row]
        service.removeTask(category: category, task: task)
        loadTasks()
    }
    
    func search(searchBar: String?){
        guard let searchBar = searchBar else { return }
        
        let resultado = tasks.filter { task in
            return task.task?.lowercased().contains(searchBar.lowercased()) ?? false
        }
        
        if searchBar != "" {
            tasks = resultado
        } else {
            loadTasks()
        }

        delegate?.atualizaTableView()
    }
    
}
