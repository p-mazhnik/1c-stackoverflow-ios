//
//  PersistentStore.swift
//  swift-course-21
//
//  Created by Pavel Mazhnik on 29.11.2021.
//

import Foundation
import CoreData
import Combine

class CoreDataManager {
    static let shared = CoreDataManager()
    private init() {}
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "AppModel")
        container.loadPersistentStores(completionHandler: { _, error in
            _ = error.map { fatalError("Unresolved error \($0)") }
        })
        return container
    }()
    
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func backgroundContext() -> NSManagedObjectContext {
        return persistentContainer.newBackgroundContext()
    }
    
    func getQuestions() -> [QuestionMO] {
            
        let request: NSFetchRequest<QuestionMO> = QuestionMO.fetchRequest()
        
        do {
            let result = try viewContext.fetch(request)
            print(result)
            return result
        } catch {
            print("fail!")
            return []
        }
        
    }
    
    func save() {
        do {
            try viewContext.save()
        } catch {
            viewContext.rollback()
            print(error.localizedDescription)
        }
    }
}
