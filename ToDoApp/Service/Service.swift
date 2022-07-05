//
//  Service.swift
//  ToDoApp
//
//  Created by Danielle Nozaki Ogawa on 2022/07/04.
//

import Foundation
import UIKit

class Service {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func saveTask(category: Category, title: String?, done: Bool){
        let task: Task = .init(context: context)
        task.task = title
        task.done = done
        category.addToTasks(task)
        saveContext()
    }
    
    func saveContext(){
        let appDelegate = (UIApplication.shared.delegate as! AppDelegate)
        appDelegate.saveContext()
    }
    
    func fetch() throws  -> [Task] {

        let tasks = try context.fetch(Task.fetchRequest())
        return tasks
    }
    
    func removeTask(category: Category, task: Task){
        category.removeFromTasks(task)
        saveContext()
    }
    
    func saveCategory(tile: String?){
        let category: Category = .init(context: context)
        category.name = tile
        saveContext()
    }
    
    func fetchCategories(completion: @escaping ([Category]) -> Void) {
        do {
            let categories = try context.fetch(Category.fetchRequest())
            completion(categories)
        } catch {
            print(error)
            completion([])
        }
    }
    
    func removeCategory(categoryName: Category) throws {
        let categories = try context.fetch(Category.fetchRequest())
        
        if let category = categories.first(where: { category in
            return category.name == categoryName.name
        }) {
            context.delete(category)
            saveContext()
        }
    }
    
}
