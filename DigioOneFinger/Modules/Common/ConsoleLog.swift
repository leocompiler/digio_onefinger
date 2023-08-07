//
//  ConsoleLog.swift
//  DigioOneFinger
//
//  Created by LEONARDO A SILVEIRA on 04/08/23.
//


import Foundation
class ConsoleLog {
    static let tag = "DigioLog"
    static func normal(message: Any?){
        ConsoleLog.normal(message: String(describing: message))
    }
    static func normal(message: String?){
        let msg = message?.data(using: .utf8)?.prettyPrintedJSONString ?? ""
        let time = Date().toString(withFormat: "HH:mm:ss.SSS") ?? "date-error"
        print("\(tag):Normal:\(time) - '\(msg)'")
    }
    
 
}
