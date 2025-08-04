
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

struct SearchUserRequest: Encodable {
    let username: String
}

struct UserResponse: Codable {
    let id: String
    let name: String
    let username: String
    let email: String?
    let appleId: String?
    let createdAt: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case username
        case email
        case appleId = "apple_id"
        case createdAt = "created_at"
    }
}
