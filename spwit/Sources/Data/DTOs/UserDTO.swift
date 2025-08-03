
//
//  SuggestedUsersResponse.swift
//  Spwit
//
//  Created by Adithya Firmansyah Putra on 04/08/25.
//


//
//  SuggestedUsersResponse.swift
//  Spwit
//
//  Created by Adithya Firmansyah Putra on 04/08/25.
//

import Foundation

struct SuggestedUsersResponse: Codable {
    let suggestedUsers: [SuggestedUser]

    enum CodingKeys: String, CodingKey {
        case suggestedUsers = "suggested_users"
    }

    struct SuggestedUser: Codable {
        let id: String
        let name: String
    }
}
