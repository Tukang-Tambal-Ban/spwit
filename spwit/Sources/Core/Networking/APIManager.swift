//
//  APIManager.swift
//  terapilah
//
//  Created by mac.bernanda on 16/08/24.
//

import Alamofire
import Foundation

struct EmptyParams: Codable {}

class APIManager {
    static let shared = APIManager()
    static let networkEnvironment: NetworkEnvironment = .stage

    private init() {}

    /// Generic API Call using Alamofire + Codable
    func call<T: Decodable, Parameters: Encodable & Sendable>(
        type: EndPointType,
        params: Parameters? = nil,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        print("Headers")
        print(type.headers)
        print("URL")
        print(type.url)
        print("HTTP Method")
        print(type.httpMethod)
        print("Params")
        print(params)
        AF.request(
            type.url,
            method: type.httpMethod,
            parameters: params is EmptyParams ? nil : params,
            encoder: type.encoder,
            headers: type.headers
        )
        .validate()
        .responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let decodedData):
                completion(.success(decodedData))
            case .failure(let error):
                print(error)
                completion(.failure(error))
            }
        }
    }
}
