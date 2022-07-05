//
//  Category+CoreDataProperties.swift
//  ToDoApp
//
//  Created by Danielle Nozaki Ogawa on 2022/07/05.
//
//

import Foundation
import CoreData


extension Category {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Category> {
        return NSFetchRequest<Category>(entityName: "Category")
    }

    @NSManaged public var name: String?
    @NSManaged public var tasks: NSSet?

    public var wrappedName: String {
        name ?? "no name"
    }
    
    public var taskArray: [Task] {
        let set = tasks as? Set<Task> ?? []
        
        return set.sorted {
            $0.wrappedTask < $1.wrappedTask
        }
    }

}

// MARK: Generated accessors for tasks
extension Category {

    @objc(addTasksObject:)
    @NSManaged public func addToTasks(_ value: Task)

    @objc(removeTasksObject:)
    @NSManaged public func removeFromTasks(_ value: Task)

    @objc(addTasks:)
    @NSManaged public func addToTasks(_ values: NSSet)

    @objc(removeTasks:)
    @NSManaged public func removeFromTasks(_ values: NSSet)

}

extension Category : Identifiable {

}
