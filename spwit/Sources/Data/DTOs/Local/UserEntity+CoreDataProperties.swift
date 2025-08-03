//
//  UserEntity+CoreDataProperties.swift
//  
//
//  Created by Adithya Firmansyah Putra on 02/08/25.
//
//

import Foundation
import CoreData


extension UserEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserEntity> {
        return NSFetchRequest<UserEntity>(entityName: "UserEntity")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var username: String?
    @NSManaged public var appleId: String?
    @NSManaged public var email: String?
    @NSManaged public var token: String?

}
