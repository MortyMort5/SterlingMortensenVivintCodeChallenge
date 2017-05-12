//
//  User+Convenience.swift
//  VivintProject
//
//  Created by Sterling Mortensen on 5/11/17.
//  Copyright © 2017 Sterling Mortensen. All rights reserved.
//

import UIKit
import CoreData

extension User {
    
    static let nameKey = "name"
    static let firstNameKey = "first"
    static let lastNameKey = "last"
    static let emailKey = "email"
    static let phoneNumberKey = "phone"
    static let picturesKey = "picture"
    static let imageURLKey = "thumbnail"
    static let resultsKey = "results"
    
    var profileImage: UIImage? {
        guard let data = self.profileData else { return nil }
        guard let image = UIImage(data: data as Data) else { return nil }
        return image
    }
    
    @discardableResult convenience init?(jsonDictionary: [String: Any], context: NSManagedObjectContext = CoreDataStack.context) {
        
        self.init(context: context)
        guard let nameList = jsonDictionary[User.nameKey] as? [String: Any],
            let firstName = nameList[User.firstNameKey] as? String,
            let lastName = nameList[User.lastNameKey] as? String,
            let email = jsonDictionary[User.emailKey] as? String,
            let phoneNumber = jsonDictionary[User.phoneNumberKey] as? String,
            let pictures = jsonDictionary[User.picturesKey] as? [String: Any],
            let imageURL = pictures[User.imageURLKey] as? String else { return nil }
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.phoneNumber = phoneNumber
        self.imageURL = imageURL
        ImageController.image(forURL: imageURL) { (image) in
            guard let image = image else { return }
            let data = UIImageJPEGRepresentation(image, 1.0) as NSData?
            self.profileData = data
        }

    }
}
