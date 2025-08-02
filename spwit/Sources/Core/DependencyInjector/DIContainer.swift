//
//  DIContainer.swift
//  yummers
//
//  Created by mac.bernanda on 03/12/24.
//

final class DIContainer {
    lazy var localDataSource: CoreDataUserDataSource = CoreDataUserDataSource()
    lazy var authRepository: AuthRepository = AuthRepositoryImpl()
    lazy var persistenceRepository: UserPersistenceRepository = UserPersistenceRepositoryImpl(localDataSource: localDataSource)
    lazy var authUsecase: AuthUsecase = AuthUsecaseImpl(authRepository: authRepository, persistanceRepo: persistenceRepository)
    
    // Singleton instance to ensure centralized DI management
    static let shared = DIContainer()
    
    private init() {}
}
