//
//  UserLocalDataSourceProtocol.swift
//  Spwit
//
//  Created by Adithya Firmansyah Putra on 02/08/25.
//


import CoreData
import UIKit

protocol UserLocalDataSourceProtocol {
    func saveUser(_ entity: SignInEntity)
    func getUser() -> SignInEntity?
    func deleteUser()
}

class CoreDataUserDataSource: UserLocalDataSourceProtocol {
    private let context: NSManagedObjectContext

    init(context: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext) {
        self.context = context
    }

    func saveUser(_ entity: SignInEntity) {
        let user = UserEntity(context: context)
        user.id = entity.userId
        user.username = entity.username
        user.email = entity.email
        user.token = entity.token
        user.appleId = entity.appleId
        user.name = entity.username //TODO: should be change into username
        try? context.save()
    }

    func getUser() -> SignInEntity? {
        let fetch = UserEntity.fetchRequest()
        if let result = try? context.fetch(fetch), let user = result.first {
            return SignInEntity(
                token: user.token ?? "",
                userId: user.id ?? "",
                appleId: user.appleId ?? "",
                email: user.email ?? "",
                username: user.username ?? "",
                name: user.name ?? ""
            )
        }
        return nil
    }

    func deleteUser() {
        let fetch = UserEntity.fetchRequest()
        if let result = try? context.fetch(fetch), let user = result.first {
            context.delete(user)
            try? context.save()
        }
    }
}
