//
//  CreateSettlementRequest.swift
//  Spwit
//
//  Created by Adithya Firmansyah Putra on 04/08/25.
//


//
//  SettlementDTO.swift
//  Spwit
//
//  Created by Adithya Firmansyah Putra on 04/08/25.
//

import Foundation

// MARK: - POST /settlements

struct CreateSettlementRequest: Codable {
    let groupId: String
    let fromUserId: String
    let toUserId: String
    let amount: Int
    let note: String

    enum CodingKeys: String, CodingKey {
        case groupId = "group_id"
        case fromUserId = "from_user_id"
        case toUserId = "to_user_id"
        case amount
        case note
    }
}

struct CreateSettlementResponse: Codable {
    let settlementId: String

    enum CodingKeys: String, CodingKey {
        case settlementId = "settlement_id"
    }
}
