//
//  Task+CoreDataProperties.swift
//  ToDoApp
//
//  Created by Danielle Nozaki Ogawa on 2022/07/05.
//
//

import Foundation
import CoreData


extension Task {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }

    @NSManaged public var done: Bool
    @NSManaged public var task: String?
    @NSManaged public var parentCategory: Category?
    
    public var wrappedTask: String {
        task ?? "no task"
    }

}

extension Task : Identifiable {

}
