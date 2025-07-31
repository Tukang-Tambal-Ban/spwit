//
//  ScenarioGenerationRepository.swift
//  terapilah
//
//  Created by mac.bernanda on 19/08/24.
//

protocol AuthRepository {
    func signIn(payload: SignInRequest) async throws -> SignInResponse
}

class AuthRepositoryImpl: AuthRepository {
    private let apiManager: APIManager = APIManager.shared
    
    func signIn(payload: SignInRequest) async throws -> SignInResponse {
        
        return try await withCheckedThrowingContinuation { continuation in
            apiManager.call(type: AuthEndpoint.signIn, params: payload) { (result: Result<SignInResponse, Error>) in
                switch result {
                case .success(let signInResponse):
                    continuation.resume(returning: signInResponse)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}
