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
    func getSuggestedUsers() async throws -> [User]
    func getUsers(username: String) async throws -> [User]
}

class UserRepositoryImpl: UserRepository {
    private let apiManager = APIManager.shared

    func getSuggestedUsers() async throws -> [User] {
        let emptyParams = EmptyParams()
        return try await withCheckedThrowingContinuation { continuation in
            apiManager.call(type: UserEndpoint.getSuggestedUsers, params: emptyParams) { (result: Result<BaseResponse<[UserResponse]>, Error>) in
                switch result {
                case .success(let response):
                    continuation.resume(returning: response.data.map(User.fromDTO))
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    
    func getUsers(username: String) async throws -> [User] {
        let params = SearchUserRequest(username: username)
        return try await withCheckedThrowingContinuation { continuation in
            apiManager.call(type: UserEndpoint.getUsers, params: params) { (result: Result<BaseResponse<[UserResponse]>, Error>) in
                switch result {
                case .success(let response):
                    continuation.resume(returning: response.data.map(User.fromDTO))
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}
