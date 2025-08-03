//
//  ExpenseRepository.swift
//  Spwit
//
//  Created by Adithya Firmansyah Putra on 04/08/25.
//


//
//  ExpenseRepository.swift
//  Spwit
//
//  Created by Adithya Firmansyah Putra on 04/08/25.
//

import Foundation

protocol ExpenseRepository {
    func createExpense(payload: CreateExpenseRequest) async throws -> CreateExpenseEntity
    func getExpenseDetail(expenseId: String) async throws -> ExpenseDetailEntity
}

class ExpenseRepositoryImpl: ExpenseRepository {
    private let apiManager = APIManager.shared

    func createExpense(payload: CreateExpenseRequest) async throws -> CreateExpenseEntity {
        return try await withCheckedThrowingContinuation { continuation in
            apiManager.call(type: ExpenseEndpoint.createExpense, params: payload) { (result: Result<BaseResponse<CreateExpenseResponse>, Error>) in
                switch result {
                case .success(let response):
                    continuation.resume(returning: CreateExpenseEntity.fromDTO(response.data))
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }

    func getExpenseDetail(expenseId: String) async throws -> ExpenseDetailEntity {
        let emptyParams = EmptyParams()
        return try await withCheckedThrowingContinuation { continuation in
            apiManager.call(type: ExpenseEndpoint.getExpenseDetail(expenseId: expenseId), params: emptyParams) { (result: Result<BaseResponse<ExpenseDetailResponse>, Error>) in
                switch result {
                case .success(let response):
                    continuation.resume(returning: ExpenseDetailEntity.fromDTO(response.data))
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}