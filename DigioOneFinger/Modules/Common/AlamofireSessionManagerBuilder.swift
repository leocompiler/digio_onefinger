//
//  AlamofireSessionManagerBuilder.swift
//  DigioOneFinger
//
//  Created by LEONARDO A SILVEIRA on 04/08/23.
//


import Alamofire
import TrustKit
import UIKit

class AlamofireSessionManagerBuilder: SessionDelegate {
        
    override func urlSession(_ session: URLSession, task: URLSessionTask, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        let trustKitInitialiazed = TrustKitCertificatePinning.sharedInstance != nil
        if !trustKitInitialiazed {
            completionHandler(.performDefaultHandling, nil)
            return
        }
        
        if TrustKit.sharedInstance().pinningValidator.handle(challenge, completionHandler: completionHandler) == false {
            completionHandler(.cancelAuthenticationChallenge, nil)
        }
    }
    
    func build() -> SessionManager {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.httpAdditionalHeaders = UIDevice().headers
        configuration.timeoutIntervalForRequest = 40 // as seconds, you can set your request timeout
        configuration.timeoutIntervalForResource = 40 // as seconds, you can set your resource timeout
        configuration.requestCachePolicy = .useProtocolCachePolicy
        return SessionManager.init(configuration: configuration, delegate: self)
    }
}
