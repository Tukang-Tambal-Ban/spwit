//
//  SignInInteractorProtocol.swift
//  spwit
//
//  Created by Adithya Firmansyah Putra on 01/08/25.
//


protocol SignInInteractorProtocol {
    func signIn(completion: @escaping (Result<SignInEntity, Error>) -> Void)
}

class SignInInteractor: SignInInteractorProtocol {
    private let authUsecase: AuthUsecase

    init(authUsecase: AuthUsecase) {
        self.authUsecase = authUsecase
    }

    func signIn(completion: @escaping (Result<SignInEntity, Error>) -> Void) {
        Task {
            let dummyPayload = SignInRequestEntity(
                identityToken: "dummy_identity_token",
                appleUserId: "dummy_apple_user_id"
            )

            let result = try await authUsecase.signIn(payload: dummyPayload)
            completion(result)
        }
    }
}