//
//  CommonDevice.swift
//  DigioOneFinger
//
//  Created by LEONARDO A SILVEIRA on 04/08/23.
//

import Foundation
import UIKit

extension UIDevice {
    var headers: [String: String] {
           get {
               ["Content-type": "application/json",
                "device_id": Device_Id,
                "session_token": coockies].filter { !$0.value.isEmpty }
           }
       }
}
