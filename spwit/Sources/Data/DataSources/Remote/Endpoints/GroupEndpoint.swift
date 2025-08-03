//
//  GroupEndpoint.swift
//  Spwit
//
//  Created by Adithya Firmansyah Putra on 04/08/25.
//


import Foundation
import Alamofire

enum GroupEndpoint {
    case getGroups
    case createGroup
    case getGroupDetail(groupId: String)
}

extension GroupEndpoint: EndPointType {
    var baseURL: String {
        switch APIManager.networkEnvironment {
        case .dev: return "http://localhost:8000/"
        case .production, .stage: return "https://spwit.onrender.com/"
        }
    }

    var version: String { "api/v1/" }
    var key: String { "groups" }

    var path: String {
        switch self {
        case .getGroups, .createGroup:
            return ""
        case .getGroupDetail(let id):
            return "/\(id)"
        }
    }

    var httpMethod: HTTPMethod {
        switch self {
        case .getGroups, .getGroupDetail: return .get
        case .createGroup: return .post
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
