//
//  CreateSettlementRequestEntity.swift
//  Spwit
//
//  Created by Adithya Firmansyah Putra on 04/08/25.
//


//
//  SettlementEntity.swift
//  Spwit
//
//  Created by Adithya Firmansyah Putra on 04/08/25.
//

import Foundation

struct CreateSettlementRequestEntity {
    let groupId: String
    let fromUserId: String
    let toUserId: String
    let amount: Int
    let note: String

    func toDTO() -> CreateSettlementRequest {
        return CreateSettlementRequest(
            groupId: groupId,
            fromUserId: fromUserId,
            toUserId: toUserId,
            amount: amount,
            note: note
        )
    }
}

struct CreateSettlementEntity {
    let settlementId: String

    static func fromDTO(_ dto: CreateSettlementResponse) -> CreateSettlementEntity {
        return CreateSettlementEntity(settlementId: dto.settlementId)
    }
}
