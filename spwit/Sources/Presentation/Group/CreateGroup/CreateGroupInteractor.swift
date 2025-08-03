//
//  CreateGroupInteractorProtocol.swift
//  spwit
//
//  Created by Adithya Firmansyah Putra on 01/08/25.
//

protocol CreateGroupInteractorProtocol {
    func createGroup(
        payload: CreateGroupRequestEntity, completion: @escaping (Result<CreateGroupEntity, Error>) -> Void
    )
}

class CreateGroupInteractor: CreateGroupInteractorProtocol {
    private let groupUsecase: GroupUsecase

     init(groupUsecase: GroupUsecase) {
         self.groupUsecase = groupUsecase
     }

     func createGroup(
        payload: CreateGroupRequestEntity, completion: @escaping (Result<CreateGroupEntity, Error>) -> Void
     ) {
         Task {
             let result = try await groupUsecase.createGroup(payload: payload)
             completion(result)
         }
     }
}
