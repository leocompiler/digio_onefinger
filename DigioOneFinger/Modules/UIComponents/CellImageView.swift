//
//  CellSingleLineIconLeft.swift
//  DigioOneFinger
//
//  Created by LEONARDO A SILVEIRA on 04/08/23.
//

import UIKit

class CellImageView: UICollectionViewCell {
    static let identfier = "CellImageView"
    @IBOutlet weak var _image: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setupCell(url: String, _ width: Int=50, _ height: Int=50) {
        self._image.setImage(imageURL: url)
        self._image.backgroundColor = .gray
        self._image.clipsToBounds = true
        self._image.layer.cornerRadius = 8
        self._image.snp.makeConstraints { make in
            make.width.equalTo(width)
            make.height.equalTo(height)
        }
    }
}
