//
//  CoreDataStack.swift
//  VivintProject
//
//  Created by Sterling Mortensen on 5/11/17.
//  Copyright © 2017 Sterling Mortensen. All rights reserved.
//

import Foundation
import CoreData

enum CoreDataStack {
    
    static let container: NSPersistentContainer =  {
        let container = NSPersistentContainer(name: "User")
        container.loadPersistentStores(completionHandler: {(storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Error loading persistent stores: \(error.userInfo)")
            }
        })
        return container
    }()
    
    static var context: NSManagedObjectContext {return container.viewContext}
}
