//
//  DIContainer.swift
//  yummers
//
//  Created by mac.bernanda on 03/12/24.
//

final class DIContainer {
    lazy var authRepository: AuthRepository = AuthRepositoryImpl()
    lazy var authUsecase: AuthUsecase = AuthUsecaseImpl(authRepository: authRepository)
    
    // Singleton instance to ensure centralized DI management
    static let shared = DIContainer()
    
    private init() {}
}
