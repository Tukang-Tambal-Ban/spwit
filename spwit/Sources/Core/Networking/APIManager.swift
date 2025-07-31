//
//  APIManager.swift
//  terapilah
//
//  Created by mac.bernanda on 16/08/24.
//

import Alamofire
import Foundation

class APIManager {
    static let shared = APIManager()
    static let networkEnvironment: NetworkEnvironment = .dev

    private init() {}

    /// Generic API Call using Alamofire + Codable
    func call<T: Decodable, Parameters: Encodable & Sendable>(
        type: EndPointType,
        params: Parameters? = nil,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        AF.request(
            type.url,
            method: type.httpMethod,
            parameters: params,
            encoder: type.encoder,
            headers: type.headers
        )
        .validate()
        .responseDecodable(of: T.self) { response in
            print("➡️ Request: \(String(describing: response.request))")
            print("⬅️ Response: \(String(describing: response.data).flatMap { _ in String(data: response.data ?? Data(), encoding: .utf8) })")

            switch response.result {
            case .success(let decodedData):
                completion(.success(decodedData))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
