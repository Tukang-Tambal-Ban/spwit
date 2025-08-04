//
//  DIContainer.swift
//  yummers
//
//  Created by mac.bernanda on 03/12/24.
//

final class DIContainer {
    lazy var localDataSource: CoreDataUserDataSource = CoreDataUserDataSource()
    lazy var persistenceRepository: UserPersistenceRepository = UserPersistenceRepositoryImpl(localDataSource: localDataSource)
    
    lazy var authRepository: AuthRepository = AuthRepositoryImpl()
    lazy var authUsecase: AuthUsecase = AuthUsecaseImpl(authRepository: authRepository, persistanceRepo: persistenceRepository)
    
    lazy var groupRepository: GroupRepository = GroupRepositoryImpl()
    lazy var groupUsecase: GroupUsecase = GroupUsecaseImpl(repository: groupRepository, persistenceRepo: persistenceRepository)
    
    lazy var userRepository: UserRepository = UserRepositoryImpl()
    lazy var userUsecase: UserUsecase = UserUsecaseImpl(repository: userRepository)
    
    lazy var expenseRepository: ExpenseRepository = ExpenseRepositoryImpl()
    lazy var expenseUsecase: ExpenseUsecase = ExpenseUsecaseImpl(repository: expenseRepository)
    
    lazy var settlementRepository: SettlementRepository = SettlementRepositoryImpl()
    lazy var settlementUsecase: SettlementUsecase = SettlementUsecaseImpl(repository: settlementRepository)
    
    // Singleton instance to ensure centralized DI management
    static let shared = DIContainer()
    
    private init() {}
}
