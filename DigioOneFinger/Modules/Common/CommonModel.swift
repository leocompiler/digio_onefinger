//
//  CommonModel.swift
//  DigioOneFinger
//
//  Created by LEONARDO A SILVEIRA on 02/08/23.
//

import Foundation
import EVReflection

class CommonModel: EVNetworkingObject {
     
    
    var _skipEmptyValues:Bool { get { return true }}
    override func skipPropertyValue(_ value: Any, key: String) -> Bool {
        if _skipEmptyValues {
            if let value = value as? String, value.count == 0 || value == "null" {
                return true
            } else if let value = value as? NSArray, value.count == 0 {
                return true
            } else if value is NSNull {
                return true
            }
            return false
        }
        return false
    }
    func getBody() -> String? {
        do {
            let dict = self.toDictionary()
            let multableDict = NSMutableDictionary(dictionary: dict)
            multableDict.forEach { (key, value) in
                if let number = value as? NSNumber {
                    let decimal = NSDecimalNumber(decimal: number.decimalValue)
                    multableDict[key] = decimal
                }
            }
            // make sure this JSON is in the format we expect
            let jsonData = try JSONSerialization.data(withJSONObject: multableDict, options: [])
            return String(decoding: jsonData, as: UTF8.self)
        } catch let error as NSError {
            print("Failed to load: \(error.localizedDescription)")
            return nil
        }
    }
  
}

