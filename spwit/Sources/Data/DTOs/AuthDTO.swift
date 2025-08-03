struct SignInRequest: Codable {
    let identityToken: String
    let appleUserId: String
    let name: String
    let email: String

    enum CodingKeys: String, CodingKey {
        case identityToken = "identity_token"
        case appleUserId = "apple_user_id"
        case name
        case email
    }

    init(from entity: SignInRequestEntity) {
        self.identityToken = entity.identityToken
        self.appleUserId = entity.appleUserId
        self.name = entity.name
        self.email = entity.email
    }
}

struct SignInResponse: Codable {
    let success: Bool
    let token: String
    let user: User

    struct User: Codable {
        let userId: String
        let appleId: String
        let email: String?
        let username: String
        let name: String

        enum CodingKeys: String, CodingKey {
            case userId = "user_id"
            case appleId = "apple_id"
            case email
            case username
            case name
        }
    }
}
