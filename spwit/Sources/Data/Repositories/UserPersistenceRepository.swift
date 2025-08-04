//
//  UserPersistenceRepositoryProtocol.swift
//  Spwit
//
//  Created by Adithya Firmansyah Putra on 02/08/25.
//


// Sources/Data/Repositories/UserPersistenceRepository.swift
protocol UserPersistenceRepository {
    func saveUser(_ entity: SignInEntity)
    func getUser() -> UserEntity?
    func deleteUser()
}

class UserPersistenceRepositoryImpl: UserPersistenceRepository {
    private let localDataSource: UserLocalDataSourceProtocol

    init(localDataSource: UserLocalDataSourceProtocol) {
        self.localDataSource = localDataSource
    }

    func saveUser(_ entity: SignInEntity) {
        localDataSource.saveUser(entity)
    }

    func getUser() -> UserEntity? {
        return localDataSource.getUser()
    }

    func deleteUser() {
        localDataSource.deleteUser()
    }
}
