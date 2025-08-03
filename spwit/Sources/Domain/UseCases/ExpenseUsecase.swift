//
//  ExpenseUsecase.swift
//  Spwit
//
//  Created by Adithya Firmansyah Putra on 04/08/25.
//


//
//  ExpenseUsecase.swift
//  Spwit
//
//  Created by Adithya Firmansyah Putra on 04/08/25.
//

import Foundation

protocol ExpenseUsecase {
    func createExpense(payload: CreateExpenseRequestEntity) async -> Result<CreateExpenseEntity, Error>
    func getExpenseDetail(expenseId: String) async -> Result<ExpenseDetailEntity, Error>
}

class ExpenseUsecaseImpl: ExpenseUsecase {
    private let repository: ExpenseRepository

    init(repository: ExpenseRepository) {
        self.repository = repository
    }

    func createExpense(payload: CreateExpenseRequestEntity) async -> Result<CreateExpenseEntity, Error> {
        do {
            let dto = payload.toDTO()
            let result = try await repository.createExpense(payload: dto)
            return .success(result)
        } catch {
            return .failure(error)
        }
    }

    func getExpenseDetail(expenseId: String) async -> Result<ExpenseDetailEntity, Error> {
        do {
            let result = try await repository.getExpenseDetail(expenseId: expenseId)
            return .success(result)
        } catch {
            return .failure(error)
        }
    }
}
