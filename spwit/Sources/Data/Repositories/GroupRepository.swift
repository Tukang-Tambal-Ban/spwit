//
//  GroupRepository.swift
//  Spwit
//
//  Created by Adithya Firmansyah Putra on 04/08/25.
//


protocol GroupRepository {
    func getGroups() async throws -> GroupsEntity
    func createGroup(payload: CreateGroupRequest) async throws -> CreateGroupEntity
    func getGroupDetail(groupId: String) async throws -> GroupDetailEntity
}

class GroupRepositoryImpl: GroupRepository {
    private let apiManager = APIManager.shared

    func getGroups() async throws -> GroupsEntity {
        let emptyParams = EmptyParams()
        return try await withCheckedThrowingContinuation { continuation in
            apiManager.call(type: GroupEndpoint.getGroups, params: emptyParams) { (result: Result<BaseResponse<GroupsResponse>, Error>) in
                switch result {
                case .success(let response):
                    let entity = GroupsEntity.fromDTO(response.data)
                    continuation.resume(returning: entity)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }

    func createGroup(payload: CreateGroupRequest) async throws -> CreateGroupEntity {
        return try await withCheckedThrowingContinuation { continuation in
            apiManager.call(type: GroupEndpoint.createGroup, params: payload) { (result: Result<BaseResponse<CreateGroupResponse>, Error>) in
                switch result {
                case .success(let response):
                    continuation.resume(returning: CreateGroupEntity.fromDTO(response.data))
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    
    func getGroupDetail(groupId: String) async throws -> GroupDetailEntity {
        let emptyParams = EmptyParams()
        return try await withCheckedThrowingContinuation { continuation in
            apiManager.call(type: GroupEndpoint.getGroupDetail(groupId: groupId), params: emptyParams) { (result: Result<BaseResponse<GroupDetailResponse>, Error>) in
                switch result {
                case .success(let response):
                    let entity = GroupDetailEntity.fromDTO(response.data)
                    continuation.resume(returning: entity)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}
