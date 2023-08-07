//
//  LayoutTools.swift
//  DigioOneFinger
//
//  Created by LEONARDO A SILVEIRA on 04/08/23.
//

import UIKit
import Foundation

class LayoutTools: UIView {
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
    }
}

protocol CodeView {
    func setupView()
    func setupConstraints()
    func setupAdditionalConfiguration()
    func buildViewHierrachy()
}

extension CodeView {
    func setupView() {
        buildViewHierrachy()
        setupConstraints()
        setupAdditionalConfiguration()
    }
}

extension UIView {
    func roundCorners(corners:UIRectCorner, radius: CGFloat) {
            self.clipsToBounds = true
            let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            self.layer.mask = mask
        }
}
