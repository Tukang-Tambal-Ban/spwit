//
//  UserUsecase.swift
//  Spwit
//
//  Created by Adithya Firmansyah Putra on 04/08/25.
//


//
//  UserUsecase.swift
//  Spwit
//
//  Created by Adithya Firmansyah Putra on 04/08/25.
//

import Foundation

protocol UserUsecase {
    func getSuggestedUsers() async -> Result<[SuggestedUserEntity], Error>
}

class UserUsecaseImpl: UserUsecase {
    private let repository: UserRepository

    init(repository: UserRepository) {
        self.repository = repository
    }

    func getSuggestedUsers() async -> Result<[SuggestedUserEntity], Error> {
        do {
            let users = try await repository.getSuggestedUsers()
            return .success(users)
        } catch {
            return .failure(error)
        }
    }
}
