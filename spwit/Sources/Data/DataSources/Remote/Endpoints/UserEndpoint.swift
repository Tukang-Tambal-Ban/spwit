//
//  UserEndpoint.swift
//  Spwit
//
//  Created by Adithya Firmansyah Putra on 04/08/25.
//


//
//  UserEndpoint.swift
//  Spwit
//
//  Created by Adithya Firmansyah Putra on 04/08/25.
//

import Foundation
import Alamofire

enum UserEndpoint {
    case getSuggestedUsers
}

extension UserEndpoint: EndPointType {
    var baseURL: String {
        switch APIManager.networkEnvironment {
        case .dev: return "http://localhost:8000/"
        case .production, .stage: return "https://spwit.onrender.com/"
        }
    }

    var version: String { "api/v1/" }
    var key: String { "users" }

    var path: String {
        switch self {
        case .getSuggestedUsers:
            return "/suggested-users"
        }
    }

    var httpMethod: HTTPMethod {
        switch self {
        case .getSuggestedUsers: return .get
        }
    }

    var headers: HTTPHeaders? {
        if let token = CoreDataUserDataSource().getUser()?.token {
            return [
                "Authorization": "Bearer \(token)",
                "Content-Type": "application/json",
                "Accept": "application/json"
            ]
        }
        return ["Content-Type": "application/json"]
    }

    var url: URL {
        return URL(string: self.baseURL + self.version + self.key + self.path)!
    }

    var encoder: ParameterEncoder {
        return JSONParameterEncoder.default
    }
}