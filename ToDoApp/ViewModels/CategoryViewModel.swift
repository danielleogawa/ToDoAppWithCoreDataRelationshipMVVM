//
//  CategoryViewModel.swift
//  ToDoApp
//
//  Created by Danielle Nozaki Ogawa on 2022/07/05.
//

import Foundation

class CategoryViewModel {
    var service = Service()

    var categories: [Category] = []
    
    func loadCategories(){
        service.fetchCategories { categories in
            self.categories = categories

        }
    }
    
    func addNewCategory(categoryName: String?){
        guard let categoryName = categoryName else { return }
        service.saveCategory(tile: categoryName)
        loadCategories()
    }
    
    func getCategoriesCount() -> Int {
        return categories.count
    }
    
    func getCategory(row: Int) -> Category {
        return categories[row]
    }
    
    func removeCategory(row: Int){
        let category = categories[row]
        do {
            try service.removeCategory(categoryName: category)
            loadCategories()
        } catch {
            print(error)
        }
    }
    
    
    func getTasks(row: Int?) -> ViewModelTasks? {
        guard let row = row else { return nil }

        let category = categories[row]
        
        let viewModel = ViewModelTasks(category: category)
        
        return viewModel
    }
}
