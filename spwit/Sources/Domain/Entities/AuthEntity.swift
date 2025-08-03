struct SignInRequestEntity {
    let identityToken: String
    let appleUserId: String
    let name: String
    let email: String
}

struct SignInEntity {
    let token: String
    let userId: String
    let appleId: String
    let email: String
    let name: String
    let username: String

    init(from dto: SignInResponse) {
        self.token = dto.token
        self.userId = dto.user.userId
        self.appleId = dto.user.appleId
        self.email = dto.user.email ?? ""
        self.username = dto.user.username
        self.name = dto.user.username //TODO: change this also into name
    }
    
    init(token: String, userId: String, appleId: String, email: String, username: String, name: String) {
        self.token = token
        self.userId = userId
        self.appleId = appleId
        self.email = email
        self.username = username
        self.name = name
    }
}
