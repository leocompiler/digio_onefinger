//
//  TrustKitCertificatePinning.swift
//  DigioOneFinger
//
//  Created by LEONARDO A SILVEIRA on 04/08/23.
//

import TrustKit
import Alamofire

final class TrustKitCertificatePinning {
    static var sharedInstance: TrustKitCertificatePinning?
    lazy var host: String? = {
        let url = URL(string: API_URL)
        return url?.host
    }()
    lazy var pins: [String]? = {
        SSL_PINS
    }()
    lazy var isEnabled: Bool = {
        self.pins != nil && self.host != nil
    }()
    static func initialize() {
        if TrustKitCertificatePinning.sharedInstance == nil {
            TrustKitCertificatePinning.sharedInstance = TrustKitCertificatePinning()
        }
        if let host = TrustKitCertificatePinning.sharedInstance?.host,
            let pins = TrustKitCertificatePinning.sharedInstance?.pins,
            let isEnabled = TrustKitCertificatePinning.sharedInstance?.isEnabled {
            let trustKitConfig: [String: Any] = [
                kTSKPinnedDomains: [
                    host: [
                        kTSKEnforcePinning: isEnabled,
                        kTSKIncludeSubdomains: true,
                        kTSKPublicKeyHashes: pins
                    ]
                ]
            ]
            TrustKit.initSharedInstance(withConfiguration: trustKitConfig)
        }
    }
}
