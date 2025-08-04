//
//  AssignExpenseInteractorProtocol.swift
//  spwit
//
//  Created by Adithya Firmansyah Putra on 01/08/25.
//

protocol SearchPeopleInteractorProtocol {
    func fetchSuggestedUsers(completion: @escaping (Result<[User], Error>) -> Void)
    func searchUsers(username: String, completion: @escaping (Result<[User], Error>) -> Void)
}

class SearchPeopleInteractor: SearchPeopleInteractorProtocol {
    private let userUsecase: UserUsecase

     init(userUsecase: UserUsecase) {
         self.userUsecase = userUsecase
     }

    func fetchSuggestedUsers(completion: @escaping (Result<[User], Error>) -> Void
     ) {
         Task {
             let result = await userUsecase.getSuggestedUsers()
             completion(result)
         }
     }
    
    func searchUsers(username: String, completion: @escaping (Result<[User], Error>) -> Void
     ) {
         Task {
             let result = await userUsecase.getUsers(username: username)
             completion(result)
         }
     }
}
