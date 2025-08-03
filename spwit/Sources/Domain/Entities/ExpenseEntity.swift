//
//  CreateExpenseEntity.swift
//  Spwit
//
//  Created by Adithya Firmansyah Putra on 04/08/25.
//


//
//  ExpenseEntity.swift
//  Spwit
//
//  Created by Adithya Firmansyah Putra on 04/08/25.
//

import Foundation

// MARK: - Create Expense

struct CreateExpenseRequestEntity {
    let groupId: String
    let title: String
    let totalAmount: Int
    let type: String
    let paidBy: PaidByEntity
    let splits: [SplitEntity]

    struct PaidByEntity {
        let userId: String
        let amountPaid: Int
    }

    struct SplitEntity {
        let userId: String
        let amountOwed: Int
    }

    func toDTO() -> CreateExpenseRequest {
        return CreateExpenseRequest(
            groupId: groupId,
            title: title,
            totalAmount: totalAmount,
            type: type,
            paidBy: CreateExpenseRequest.PaidBy(
                userId: paidBy.userId,
                amountPaid: paidBy.amountPaid
            ),
            splits: splits.map {
                CreateExpenseRequest.Split(
                    userId: $0.userId,
                    amountOwed: $0.amountOwed
                )
            }
        )
    }
}

struct CreateExpenseEntity {
    let expenseId: String

    static func fromDTO(_ dto: CreateExpenseResponse) -> CreateExpenseEntity {
        return CreateExpenseEntity(expenseId: dto.expenseId)
    }
}

// MARK: - Expense Detail

struct ExpenseDetailEntity {
    let expenseId: String
    let groupId: String
    let title: String
    let totalAmount: Int
    let type: String
    let paidBy: PaidByEntity
    let splits: [SplitEntity]
    let createdBy: UserEntity
    let createdAt: String

    static func fromDTO(_ dto: ExpenseDetailResponse) -> ExpenseDetailEntity {
        return ExpenseDetailEntity(
            expenseId: dto.expenseId,
            groupId: dto.groupId,
            title: dto.title,
            totalAmount: dto.totalAmount,
            type: dto.type,
            paidBy: PaidByEntity(
                userId: dto.paidBy.userId,
                name: dto.paidBy.name,
                amountPaid: dto.paidBy.amountPaid
            ),
            splits: dto.splits.map {
                SplitEntity(userId: $0.userId, name: $0.name, amountOwed: $0.amountOwed)
            },
            createdBy: UserEntity(
                userId: dto.createdBy.userId,
                name: dto.createdBy.name
            ),
            createdAt: dto.createdAt
        )
    }

    struct PaidByEntity {
        let userId: String
        let name: String
        let amountPaid: Int
    }

    struct SplitEntity {
        let userId: String
        let name: String
        let amountOwed: Int
    }

    struct UserEntity {
        let userId: String
        let name: String
    }
}
