//
//  CustomRepository.swift
//  DigioOneFinger
//
//  Created by LEONARDO A SILVEIRA on 04/08/23.
//

import Foundation
import UIKit
import Moya
import Alamofire
import RxSwift
import EVReflection

var logEndpoint = ""
var logStatusCode = ""

class CustomRepository {
    
    class var isConnectedToInternet: Bool {
        return NetworkReachabilityManager()!.isReachable
    }
    
    static func errorBlock(subscribeError: Error, error: @escaping (ErrorResponse)->()) {
        let errorResponse = ErrorResponse()
        if let moyaError = subscribeError as? MoyaError, let response = moyaError.response {
            logEndpoint = response.request?.url?.absoluteString ?? ""
            logStatusCode = "\(response.response?.statusCode ?? 0)"
            if !isConnectedToInternet {
                errorResponse.title = "alert"
                errorResponse.message = "unavailable_network"
                errorResponse.statusCode = -1
            } else {
                errorResponse.title = "system_unavailable_title"
                errorResponse.message = "system_unavailable_error"
                errorResponse.statusCode = -1
            }
        } else {
            errorResponse.message = subscribeError.localizedDescription
        }
        error(errorResponse)
    }
    
}

extension Response {
    fileprivate func logDebug() {
        let requestData: String = """
        - \(String(describing: self.request?.httpMethod ?? ""))
        - Headers: \(self.request?.allHTTPHeaderFields ?? ["":""])
        - StatusCode: \(statusCode)
        - Endpoint: \(String(describing: self.request?.url?.absoluteString ?? ""))
        """
        ConsoleLog.normal(message: requestData)
    }
    func parse(success: @escaping (Response)->(), error: @escaping (ErrorResponse)->()) {
        logEndpoint = self.request?.url?.absoluteString ?? ""
        logStatusCode = "\(statusCode)"
        logDebug()
        success(self)
     }
    func convertStringToDictionary() -> NSDictionary? {
        do {
            return try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? NSDictionary
        } catch {
            ConsoleLog.normal(message: "Response: Estrutura do payload inválido (precisa ser JSON)")
        }
        return nil
    }
}

func loadJson(filename fileName: String) -> String {
    if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
        do {
            let data = try Data(contentsOf: url)
            return String(decoding: data, as: UTF8.self)
        } catch {
            ConsoleLog.normal(message: "error:\(error)")
        }
    }
    return ""
}

extension PrimitiveSequenceType where Self.TraitType == RxSwift.SingleTrait {
    // MARK: Single Sucess
    func singleSubscribe(onSuccess: @escaping () -> (), onError: @escaping (ErrorResponse) -> ()) -> Disposable {
        return self.subscribe(onSuccess: { (response) in
            if let response = response as? Response {
                response.parse(success: { (successResponse) in
                    onSuccess()
                }, error: { (error) in
                    onError(error)
                })
            }
        }, onError: { (error) in
            CustomRepository.errorBlock(subscribeError: error, error: { (error) in
                onError(error)
            })
        })
    }
    func singleSubscribeAsync(onSuccess: @escaping () -> (), onError: @escaping (ErrorResponse) -> ()) -> Disposable {
        return self.subscribe(onSuccess: { (response) in
            DispatchQueue.global(qos:  .userInitiated).async {
                if let response = response as? Response {
                    response.parse(success: { (successResponse) in
                        ConsoleLog.normal(message: "Sucess!")
                        DispatchQueue.main.async {
                            onSuccess()
                        }
                    }, error: { (error) in
                        DispatchQueue.main.async {
                            onError(error)
                        }
                    })
                }
            }
        }, onError: { (error) in
            CustomRepository.errorBlock(subscribeError: error, error: { (error) in
                onError(error)
            })
        })
    }
    // MARK: Single functions
    func singleSubscribe<T: CommonModel>(onSuccess: @escaping (T) -> (), onError: @escaping (ErrorResponse) -> ()) -> Disposable {
        return self.subscribe(onSuccess: { (response) in
            if let response = response as? Response {
                response.parse(success: { (successResponse) in
                    let data = response.data
                    let dict = convertStringToDictionary(data: data)
                    let resultData = T(dictionary: dict ?? .init())
                    DispatchQueue.main.async {
                        onSuccess(resultData)
                    }
                }, error: { (error) in
                    onError(error)
                })
            }
        }, onError: { (error) in
            CustomRepository.errorBlock(subscribeError: error, error: { (error) in
                onError(error)
            })
        })
    }
    func singleSubscribe<T: CommonModel>(onSuccess: @escaping (T) -> (), onError: @escaping (Int, String) -> ()) -> Disposable {
        return self.subscribe(onSuccess: { (response) in
            if let response = response as? Response {
                response.parse(success: { (successResponse) in
                    let data = response.data
                    let dict = convertStringToDictionary(data: data)
                    let resultData = T(dictionary: dict ?? .init())
                    DispatchQueue.main.async {
                        onSuccess(resultData)
                    }
                }, error: { (error) in
                    onError(error.statusCode, error.message)
                })
            }
        }, onError: { (error) in
            CustomRepository.errorBlock(subscribeError: error, error: { (error) in
                onError(error.statusCode, error.message)
            })
        })
    }
    func singleSubscribeAsync<T: CommonModel>(onSuccess: @escaping (T) -> (), onError: @escaping (ErrorResponse) -> ()) -> Disposable {
        return self.subscribe(onSuccess: { (response) in
            DispatchQueue.global(qos:  .userInteractive).async {
                if let response = response as? Response {
                    response.parse(success: { (successResponse) in
                        let data = response.data
                        let dict = convertStringToDictionary(data: data)
                        let resultData = T(dictionary: dict ?? .init())
                        DispatchQueue.main.async {
                            onSuccess(resultData)
                        }
                    }, error: { (error) in
                        DispatchQueue.main.async {
                            onError(error)
                        }
                    })
                }
            }
        }, onError: { (error) in
            DispatchQueue.main.async {
                CustomRepository.errorBlock(subscribeError: error, error: { (error) in
                    onError(error)
                })
            }
        })
    }
    // MARK: Private methods aux json convert
    func convertStringToDictionary(data: Data) -> NSDictionary? {
        guard let jsonString = String(data: data, encoding: .utf8) else {
            return .init()
        }
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? NSDictionary
            return json
        } catch {
            ConsoleLog.normal(message: "(convertStringToDictionary) Estrutura do payload inválido (precisa ser JSON)")
        }
        return nil
    }
    func convertStringToArrayDictionary(data: Data) -> [NSDictionary]? {
        guard let jsonString = String(data: data, encoding: .utf8) else {
            return []
        }
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [NSDictionary]
            return json
        } catch {
            ConsoleLog.normal(message: "(convertStringToArrayDictionary) Estrutura do payload inválido (precisa ser JSON)")
        }
        return nil
    }    
}
