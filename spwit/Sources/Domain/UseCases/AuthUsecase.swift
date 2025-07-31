//
//  MealsUseCase.swift
//  yummers
//
//  Created by mac.bernanda on 03/12/24.
//

protocol AuthUsecase {
    func signIn(payload: SignInRequestEntity) async throws -> Result<SignInEntity, Error>
}

class AuthUsecaseImpl: AuthUsecase {
    private let authRepository: AuthRepository

    init(authRepository: AuthRepository) {
        self.authRepository = authRepository
    }

    func signIn(payload: SignInRequestEntity) async -> Result<SignInEntity, Error> {
        do {
            let signInRequest = SignInRequest(from: payload)
            let signInDTO = try await authRepository.signIn(payload: signInRequest)
            let signInEntity = SignInEntity(from: signInDTO)
            return .success(signInEntity)
        } catch {
            return .failure(error)
        }
    }
}
