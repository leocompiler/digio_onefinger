//
//  ErrorResponse.swift
//  DigioOneFinger
//
//  Created by LEONARDO A SILVEIRA on 02/08/23.
//

import Foundation

class ErrorResponse: CommonModel {
    var message: String = "unknown_error"
    var title: String = "ops"
    var statusCode: Int = -1
    var data: NSDictionary?
    var code: NSNumber?
    var originalMessage: String?
    func getData<T: CommonModel>(_ tag: String, _ type: T.Type) -> T? {
        guard let data = self.data?[tag] else { return nil }
        guard let dict = data as? NSDictionary else { return nil }
        return T(dictionary: dict)
    }
    override open func propertyMapping() -> [(keyInObject: String?, keyInResource: String?)] {
        return [
            (keyInObject: "originalMessage", keyInResource: "original_message")
        ]
    }
}
