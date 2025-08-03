//
//  BaseResponse.swift
//  Spwit
//
//  Created by Adithya Firmansyah Putra on 04/08/25.
//

struct BaseResponse<T: Codable>: Codable {
    let status: Int
    let message: String
    var data: T
}
