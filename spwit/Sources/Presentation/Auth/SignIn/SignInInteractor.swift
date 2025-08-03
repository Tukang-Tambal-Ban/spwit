//
//  SignInInteractorProtocol.swift
//  spwit
//
//  Created by Adithya Firmansyah Putra on 01/08/25.
//


protocol SignInInteractorProtocol {
    func signIn(payload: SignInRequestEntity, completion: @escaping (Result<SignInEntity, Error>) -> Void)
}

class SignInInteractor: SignInInteractorProtocol {
    private let authUsecase: AuthUsecase

    init(authUsecase: AuthUsecase) {
        self.authUsecase = authUsecase
    }

    func signIn(payload: SignInRequestEntity, completion: @escaping (Result<SignInEntity, Error>) -> Void) {
        Task {
            let result = try await authUsecase.signIn(payload: payload)
            completion(result)
        }
    }
}
