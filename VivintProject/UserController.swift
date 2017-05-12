//
//  UserController.swift
//  VivintProject
//
//  Created by Sterling Mortensen on 5/11/17.
//  Copyright © 2017 Sterling Mortensen. All rights reserved.
//

import Foundation
import CoreData

class UserController {
    
    let baseURL = URL(string: "https://randomuser.me/api/")
    
    static let shared = UserController()
    var users: [User] {
        let request: NSFetchRequest<User> = User.fetchRequest()
        let moc = CoreDataStack.context
        do {
            return try moc.fetch(request)
        } catch  {
            return []
        }
    }
    
    func fetchUsers(_ numberOfUsersToFetch: String, completion: @escaping() -> Void) {
        guard let url = baseURL else { completion(); return }
        let urlParameters = ["results": numberOfUsersToFetch]
        NetworkController.performRequest(for: url, httpMethod: .Get, urlParameters: urlParameters) { (data, error) in
            if let error = error {
                print("Error with fetching Users from API: \(error.localizedDescription)")
                completion()
                return
            }
            
            guard let data = data,
                let responseStringData = String(data: data, encoding: .utf8) else { print("Error with converting data into a String"); completion(); return }
            
            guard let jsonDict = (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)) as? [String: Any],
                let dictionary = jsonDict[User.resultsKey] as? [[String: Any]] else { print("Error with converting data into dictionary: \(responseStringData)"); completion(); return }
            
            let _ = dictionary.flatMap({ User(jsonDictionary: $0) })
            self.saveToPersistentStore()
            completion()
        }
    }
    
    func saveToPersistentStore() {
        let moc = CoreDataStack.context
        do {
            try moc.save()
        } catch let error {
            print("Error with saving to the persistent store \(error)")
        }
    }
    
    func deleteDataInPersistentStore(completion: @escaping() -> Void) {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: request)
        let moc = CoreDataStack.context
        do {
            try moc.execute(deleteRequest)
            completion()
        } catch let error as NSError {
            print("Error with deleting from persistent store: \(error)")
            completion()
        }
    }
}







