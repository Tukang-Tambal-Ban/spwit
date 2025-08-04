//
//  SuggestedUserEntity.swift
//  Spwit
//
//  Created by Adithya Firmansyah Putra on 04/08/25.
//


//
//  SuggestedUserEntity.swift
//  Spwit
//
//  Created by Adithya Firmansyah Putra on 04/08/25.
//

import Foundation

struct User: Equatable, Hashable {
    let id: String
    let name: String
    let username: String
    let appleID: String
    let email: String
    let createdAt: Date

    static func fromDTO(_ dto: UserResponse) -> User {
        return User(
            id: dto.id,
            name: dto.name,
            username: dto.username,
            appleID: dto.appleId ?? "",
            email: dto.email ?? "",
            createdAt: Date(timeIntervalSince1970: TimeInterval(dto.createdAt) ?? 0)
        )
    }
}
