//
//  GroupUsecase.swift
//  Spwit
//
//  Created by Adithya Firmansyah Putra on 04/08/25.
//


protocol GroupUsecase {
    func getGroups() async -> Result<GroupsEntity, Error>
    func createGroup(payload: CreateGroupRequestEntity) async throws -> Result<CreateGroupEntity, Error>
    func getGroupDetail(groupId: String) async -> Result<GroupDetailEntity, Error>
    func getCurrentUser() async -> UserEntity?
}

class GroupUsecaseImpl: GroupUsecase {
    
    private let repository: GroupRepository
    private let persistenceRepo: UserPersistenceRepository

    init(repository: GroupRepository, persistenceRepo: UserPersistenceRepository) {
        self.repository = repository
        self.persistenceRepo = persistenceRepo
    }

    func getGroups() async -> Result<GroupsEntity, Error> {
        do {
            let groups = try await repository.getGroups()
            return .success(groups)
        } catch {
            return .failure(error)
        }
    }

    func createGroup(payload: CreateGroupRequestEntity) async -> Result<CreateGroupEntity, Error> {
        do {
            let createGroupRequest = CreateGroupRequest(name: payload.name, memberIds: payload.memberIds)
            let groupId = try await repository.createGroup(payload: createGroupRequest)
            return .success(groupId)
        } catch {
            return .failure(error)
        }
    }
    
    func getGroupDetail(groupId: String) async -> Result<GroupDetailEntity, Error> {
        do {
            let detail = try await repository.getGroupDetail(groupId: groupId)
            return .success(detail)
        } catch {
            return .failure(error)
        }
    }
    
    func getCurrentUser() async -> UserEntity? {
        return persistenceRepo.getUser()
    }
}
