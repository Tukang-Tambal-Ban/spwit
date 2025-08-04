//
//  CreateGroupInteractor.swift
//  Spwit
//
//  Created by Shafa Tiara Tsabita Himawan on 02/08/25.
//

import UIKit

protocol CreateGroupInteractorProtocol: AnyObject {
    func createGroup(payload: CreateGroupRequestEntity, completion: @escaping (Result<CreateGroupEntity, Error>) -> Void)
    func getCurrentUser(completions: @escaping (UserEntity?) -> Void)
}

class CreateGroupInteractor: CreateGroupInteractorProtocol{
    private let groupUsecase: GroupUsecase

    init(groupUsecase: GroupUsecase) {
        self.groupUsecase = groupUsecase
    }

    func createGroup(payload: CreateGroupRequestEntity, completion: @escaping (Result<CreateGroupEntity, Error>) -> Void) {
        Task {
            let result = try await groupUsecase.createGroup(payload: payload)
            completion(result)
        }
    }
    
    func getCurrentUser(completions: @escaping (UserEntity?) -> Void) {
        Task {
            let result = await groupUsecase.getCurrentUser()
            completions(result)
        }
    }
}
