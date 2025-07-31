struct SignInRequestEntity {
    let identityToken: String
    let appleUserId: String
}

struct SignInEntity {
    let token: String
    let userId: String
    let appleId: String
    let email: String
    let username: String

    init(from dto: SignInResponse) {
        self.token = dto.token
        self.userId = dto.user.userId
        self.appleId = dto.user.appleId
        self.email = dto.user.email
        self.username = dto.user.username
    }
}
