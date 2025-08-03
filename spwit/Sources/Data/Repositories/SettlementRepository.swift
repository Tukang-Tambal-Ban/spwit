//
//  SettlementRepository.swift
//  Spwit
//
//  Created by Adithya Firmansyah Putra on 04/08/25.
//


//
//  SettlementRepository.swift
//  Spwit
//
//  Created by Adithya Firmansyah Putra on 04/08/25.
//

import Foundation

protocol SettlementRepository {
    func createSettlement(payload: CreateSettlementRequest) async throws -> CreateSettlementEntity
}

class SettlementRepositoryImpl: SettlementRepository {
    private let apiManager = APIManager.shared

    func createSettlement(payload: CreateSettlementRequest) async throws -> CreateSettlementEntity {
        return try await withCheckedThrowingContinuation { continuation in
            apiManager.call(type: SettlementEndpoint.createSettlement, params: payload) { (result: Result<BaseResponse<CreateSettlementResponse>, Error>) in
                switch result {
                case .success(let response):
                    let entity = CreateSettlementEntity.fromDTO(response.data)
                    continuation.resume(returning: entity)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}
