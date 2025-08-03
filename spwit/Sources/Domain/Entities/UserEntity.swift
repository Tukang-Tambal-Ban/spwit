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

struct SuggestedUserEntity: Equatable {
    let id: String
    let name: String

    static func fromDTO(_ dto: SuggestedUsersResponse.SuggestedUser) -> SuggestedUserEntity {
        return SuggestedUserEntity(
            id: dto.id,
            name: dto.name
        )
    }

    static func listFromDTO(_ dto: SuggestedUsersResponse) -> [SuggestedUserEntity] {
        return dto.suggestedUsers.map { SuggestedUserEntity.fromDTO($0) }
    }
}