//
//  SettlementUsecase.swift
//  Spwit
//
//  Created by Adithya Firmansyah Putra on 04/08/25.
//


//
//  SettlementUsecase.swift
//  Spwit
//
//  Created by Adithya Firmansyah Putra on 04/08/25.
//

import Foundation

protocol SettlementUsecase {
    func createSettlement(payload: CreateSettlementRequestEntity) async -> Result<CreateSettlementEntity, Error>
}

class SettlementUsecaseImpl: SettlementUsecase {
    private let repository: SettlementRepository

    init(repository: SettlementRepository) {
        self.repository = repository
    }

    func createSettlement(payload: CreateSettlementRequestEntity) async -> Result<CreateSettlementEntity, Error> {
        do {
            let dto = payload.toDTO()
            let result = try await repository.createSettlement(payload: dto)
            return .success(result)
        } catch {
            return .failure(error)
        }
    }
}
