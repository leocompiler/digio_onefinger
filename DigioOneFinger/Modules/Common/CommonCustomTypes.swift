//
//  CommonString.swift
//  DigioOneFinger
//
//  Created by LEONARDO A SILVEIRA on 02/08/23.
//

import Foundation
import UIKit
import SDWebImage

protocol Localizable {
    var localized: String { get }
}
extension String: Localizable {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
extension String {
    static func localized(withKey key: String) -> String {
        let defaults = UserDefaults.standard
        let language = defaults.object(forKey: KEY_USER_LANGUAGE) as? String
        let path = Bundle.main.path(forResource: language, ofType: "lproj")
        let bundle = Bundle(path: path!)
        return NSLocalizedString(key, tableName: nil, bundle: bundle!, value: "", comment: "")
    }
    var encryptedData: Data {
        EncryptModel(encryptJson: self).toJsonData()
    }
}

extension Data {
    var prettyPrintedJSONString: String? { /// NSString gives us a nice sanitized debugDescription
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = String(data: data, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue)) else {
            return String(data: self, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
        }
        return prettyPrintedString
    }
    var string: String {
        get {
            String(decoding: self, as: UTF8.self)
        }
    }
}

extension Date {
    func toString(withFormat format: String, capitalizeMonth: Bool = false) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.locale = Locale(identifier: defaultLocale)
        dateFormatter.timeZone = TimeZone(identifier: "GMT-3")
        if capitalizeMonth { dateFormatter.shortMonthSymbols = dateFormatter.shortMonthSymbols.map {
            $0.localizedCapitalized.replacingOccurrences(of: ".", with: "") }
        }
        return dateFormatter.string(from: self)
    }
}

extension UIImageView {
    func setImage(imageURL: String?, placeholder: String = "placeholder-no-photo") {
        if let imgURL = imageURL {
            if imgURL.count <= 0 || imgURL.contains("miss") {
                self.image = UIImage(named: placeholder)
            } else {
                UIView.animate(withDuration: 0.5) {
                    self.sd_setImage(with: URL(string: imgURL), completed: nil)
                }
            }
        } else {
            self.image = UIImage(named: placeholder)
        }
    }
    func outerView() -> UIView {
        let outerView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        outerView.clipsToBounds = false
        outerView.layer.shadowColor = UIColor.black.cgColor
        outerView.layer.shadowOpacity = 1
        outerView.layer.shadowOffset = CGSize.zero
        outerView.layer.shadowRadius = 10
        outerView.layer.shadowPath = UIBezierPath(roundedRect: outerView.bounds, cornerRadius: 10).cgPath
        return outerView
    }
}

extension UIScrollView {
    func updateContentView() {
        let width = contentSize.width
        contentSize = CGSize(width: width, height: UIScreen.main.bounds.height)
    }
}
