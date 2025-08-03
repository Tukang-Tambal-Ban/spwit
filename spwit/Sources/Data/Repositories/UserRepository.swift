//
//  UserRepository.swift
//  Spwit
//
//  Created by Adithya Firmansyah Putra on 04/08/25.
//


//
//  UserRepository.swift
//  Spwit
//
//  Created by Adithya Firmansyah Putra on 04/08/25.
//

import Foundation

protocol UserRepository {
    func getSuggestedUsers() async throws -> [SuggestedUserEntity]
}

class UserRepositoryImpl: UserRepository {
    private let apiManager = APIManager.shared

    func getSuggestedUsers() async throws -> [SuggestedUserEntity] {
        let emptyParams = EmptyParams()
        return try await withCheckedThrowingContinuation { continuation in
            apiManager.call(type: UserEndpoint.getSuggestedUsers, params: emptyParams) { (result: Result<BaseResponse<SuggestedUsersResponse>, Error>) in
                switch result {
                case .success(let response):
                    let entities = SuggestedUserEntity.listFromDTO(response.data)
                    continuation.resume(returning: entities)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}