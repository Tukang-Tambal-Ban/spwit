import Alamofire
import Foundation

enum AuthEndpoint {
    case signIn
}

extension AuthEndpoint: EndPointType {
    var baseURL: String {
        switch APIManager.networkEnvironment {
        case .dev: return "https://spwit.onrender.com/"
        case .production: return ""
        case .stage: return ""
        }
    }
    
    var version: String {
        return "api/v1/"
    }
    
    var key : String {
        return "auth/"
    }
    
    var path: String {
        switch self {
            
        case .signIn:
            return "apple-login"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .signIn:
            return .post
        }
    }
    
    var headers: HTTPHeaders? {
        switch self {
        case .signIn:
            return ["Content-Type": "application/json",
                    "Accept": "application/json"]
        }
    }
    
    var url: URL {
        switch self {
        default:
            return URL(string: self.baseURL + self.version + self.key + self.path)!
        }
    }
    
    var encoder: ParameterEncoder {
        switch self {
        default:
            return JSONParameterEncoder.default
            
        }
    }
    
}

