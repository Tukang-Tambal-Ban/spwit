struct AppleSignInRequest: Codable {
    let identityToken: String
    let appleUserId: String

    enum CodingKeys: String, CodingKey {
        case identityToken = "identity_token"
        case appleUserId = "apple_user_id"
    }
}

struct AppleSignInResponse: Codable {
    let success: Bool
    let token: String
    let user: User

    struct User: Codable {
        let userId: String
        let appleId: String
        let email: String
        let username: String

        enum CodingKeys: String, CodingKey {
            case userId = "user_id"
            case appleId = "apple_id"
            case email
            case username
        }
    }
}
