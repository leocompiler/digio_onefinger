import Foundation
import Moya

fileprivate let PRODUTCT_LIST = "sandbox/products"
 

enum ApiServiceMarketProducts {
    case list
}

extension ApiServiceMarketProducts: TargetType {
    var apiVersion: String {
        return "v1"
    }
    var namespace: String {
        return "market-products"
    }

    var baseURL: URL {
        //return URL(string: "\(API_URL)/\(apiVersion)/\(namespace)" )!
        return URL(string:"\(API_URL)")!
    }
    
    var path: String {
        switch self {
        case .list:
            return PRODUTCT_LIST
        }
 
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        switch self {
        case .list:
            return loadJson(filename: "market-products").encryptedData
        }
 
    }
    
    var task: Task {
        switch self {
        case .list:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return UIDevice().headers
    }
}
