//
//  EncryptModel.swift
//  DigioOneFinger
//
//  Created by LEONARDO A SILVEIRA on 04/08/23.
//

import Foundation

class EncryptModel: CommonModel {
    var data: String?
    var message: String?
    convenience init(encryptJson: String) {
        self.init()
        self.data = ""//AESCrypt.encrypt(encryptJson)
    }

}
