//
//  SessionManager.swift
//  Spwit
//
//  Created by Adithya Firmansyah Putra on 02/08/25.
//


import CoreData
import UIKit

final class SessionManager {
    static let shared = SessionManager()

    private let context: NSManagedObjectContext

    private init(context: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext) {
        self.context = context
    }

    func isUserLoggedIn() -> Bool {
        let fetch: NSFetchRequest<UserEntity> = UserEntity.fetchRequest()
        let user = try? context.fetch(fetch)
        return (user?.first != nil)
    }

    func getSignedInUser() -> SignInEntity? {
        guard let user = try? context.fetch(UserEntity.fetchRequest()).first else { return nil }
        return SignInEntity(
            token: user.token ?? "",
            userId: user.id ?? "",
            appleId: user.appleId ?? "",
            email: user.email ?? "",
            username: user.username ?? "",
            name: user.name ?? ""
        )
    }

    func clearSession() {
        let fetch: NSFetchRequest<UserEntity> = UserEntity.fetchRequest()
        if let users = try? context.fetch(fetch) {
            for user in users {
                context.delete(user)
            }
            try? context.save()
        }
    }
}
