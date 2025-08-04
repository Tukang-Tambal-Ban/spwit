//
//  HomeInteractor.swift
//  spwit
//
//  Created by Shafa Tiara Tsabita Himawan on 31/07/25.
//
import UIKit

protocol HomeInteractorProtocol: AnyObject {
    func fetchGroups(completion: @escaping (Result<GroupsEntity, Error>) -> Void)
}
class HomeInteractor: HomeInteractorProtocol {
    private let groupUsecase: GroupUsecase

    init(groupUsecase: GroupUsecase) {
        self.groupUsecase = groupUsecase
    }

    func fetchGroups(completion: @escaping (Result<GroupsEntity, Error>) -> Void) {
        Task {
            let result = await groupUsecase.getGroups()
            completion(result)
        }
    }
}
