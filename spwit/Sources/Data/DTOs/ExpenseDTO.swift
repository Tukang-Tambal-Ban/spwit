//
//  CreateExpenseRequest.swift
//  Spwit
//
//  Created by Adithya Firmansyah Putra on 04/08/25.
//


//
//  ExpenseDTO.swift
//  Spwit
//
//  Created by Adithya Firmansyah Putra on 04/08/25.
//

import Foundation

// MARK: - POST /expenses

struct CreateExpenseRequest: Codable {
    let groupId: String
    let title: String
    let totalAmount: Int
    let type: String
    let paidBy: PaidBy
    let splits: [Split]

    enum CodingKeys: String, CodingKey {
        case groupId = "group_id"
        case title
        case totalAmount = "total_amount"
        case type
        case paidBy = "paid_by"
        case splits
    }

    struct PaidBy: Codable {
        let userId: String
        let amountPaid: Int

        enum CodingKeys: String, CodingKey {
            case userId = "user_id"
            case amountPaid = "amount_paid"
        }
    }

    struct Split: Codable {
        let userId: String
        let amountOwed: Int

        enum CodingKeys: String, CodingKey {
            case userId = "user_id"
            case amountOwed = "amount_owed"
        }
    }
}

struct CreateExpenseResponse: Codable {
    let expenseId: String

    enum CodingKeys: String, CodingKey {
        case expenseId = "expense_id"
    }
}

// MARK: - GET /expenses/{expense_id}

struct ExpenseDetailResponse: Codable {
    let expenseId: String
    let groupId: String
    let title: String
    let totalAmount: Int
    let type: String
    let paidBy: PaidByDetail
    let splits: [SplitDetail]
    let createdBy: UserSummary
    let createdAt: String

    enum CodingKeys: String, CodingKey {
        case expenseId = "expense_id"
        case groupId = "group_id"
        case title
        case totalAmount = "total_amount"
        case type
        case paidBy = "paid_by"
        case splits
        case createdBy = "created_by"
        case createdAt = "created_at"
    }

    struct PaidByDetail: Codable {
        let userId: String
        let name: String
        let amountPaid: Int

        enum CodingKeys: String, CodingKey {
            case userId = "user_id"
            case name
            case amountPaid = "amount_paid"
        }
    }

    struct SplitDetail: Codable {
        let userId: String
        let name: String
        let amountOwed: Int

        enum CodingKeys: String, CodingKey {
            case userId = "user_id"
            case name
            case amountOwed = "amount_owed"
        }
    }

    struct UserSummary: Codable {
        let userId: String
        let name: String

        enum CodingKeys: String, CodingKey {
            case userId = "user_id"
            case name
        }
    }
}