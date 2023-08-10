//
//  HomeView.swift
//  DigioOneFinger
//
//  Created by LEONARDO A SILVEIRA on 01/08/23.
//

import Foundation
import UIKit
enum TypeCollection: Int {
    case SPOTLIGHT = 0
    case PRODUCT = 1
    case BANNER=2
}
protocol HomeViewDelegate: AnyObject {
    func onTapButton(_ index: Int, type: TypeCollection )
}

class HomeView: LayoutTools {
        let delegate: HomeViewDelegate
        private lazy var contentView: UIView = {
            let view = UIView()
            view.backgroundColor = .white
            return view
        }()
        lazy var iconTitle: UIImageView = {
            let img = UIImageView()
            img.image = UIImage( named: "icon_user_title")
            img.contentMode = .scaleAspectFill
            img.tintColor = .black
            return img
        }()
        lazy var labelTitle: UILabel = makeLabel( title: "home_title".localized,
                                              font: UIFont(name: regularDMSans, size: 24),
                                              color: UIColor.black)

        lazy var stackViewTitle: UIStackView = {
            let views: [UIView] = [iconTitle, labelTitle]
            let stack = UIStackView(arrangedSubviews: views)
            stack.axis = .horizontal
            stack.distribution = .fill
            stack.alignment = .fill
            stack.spacing = 5
            stack.translatesAutoresizingMaskIntoConstraints = false
            stack.isLayoutMarginsRelativeArrangement = false
            return stack
        }()
    let width = Int(UIScreen.main.bounds.width)
    lazy var spotLightView = CollectionImageView(   listItens: [],
                                                    identfier: "spot",
                                                    delegate: self,
                                                    type: .SPOTLIGHT,
                                                    width: width,
                                                    height: 100)
    lazy var titleBannerCash: UILabel = makeLabel( title: "Digio Cash".localized,
                                                   font: UIFont(name: boldDMSans, size: 18),
                                                   color: UIColor.black)

        lazy var imageBannerCash: UIImageView = {
            let img = UIImageView()
            img.image = UIImage( named: "")
            img.contentMode = .scaleAspectFill
            img.backgroundColor = .gray
            img.clipsToBounds = true
            img.layer.cornerRadius = 8
            let showOrHideTap = UITapGestureRecognizer(target: self, action: #selector(showOrHideTapped))
            img.isUserInteractionEnabled = true
            img.addGestureRecognizer(showOrHideTap)

            return img
        }()
        lazy var stackViewBanner: UIStackView = {
           let views: [UIView] = [titleBannerCash, imageBannerCash]
           let stack = UIStackView(arrangedSubviews: views)
                   stack.axis = .vertical
                   stack.distribution = .fill
                   stack.alignment = .fill
                   stack.spacing = 10
                   stack.translatesAutoresizingMaskIntoConstraints = false
                   stack.isLayoutMarginsRelativeArrangement = false
        return stack
        }( )
        lazy var productTitle: UILabel = makeLabel( title: "Produtos".localized,
                                              font: UIFont(name: boldDMSans, size: 18),
                                              color: UIColor.black)
        lazy var productView = CollectionImageView(listItens: [],
                                                   identfier: "product",
                                                   delegate: self,
                                                   type: .PRODUCT,
                                                   width: 100,
                                                   height: 100)
        lazy var stackViewProduct: UIStackView = {
           let views: [UIView] = [productTitle, productView]
           let stack = UIStackView(arrangedSubviews: views)
                   stack.axis = .vertical
                   stack.distribution = .fill
                   stack.alignment = .fill
                   stack.spacing = 10
                   stack.translatesAutoresizingMaskIntoConstraints = false
                   stack.isLayoutMarginsRelativeArrangement = false
            return stack
        }( )
        lazy var bodyViewStack: UIStackView = {
           let views: [UIView] = [stackViewTitle, spotLightView, stackViewBanner, stackViewProduct]
           let stack = UIStackView( arrangedSubviews: views)
            stack.axis = .vertical
            stack.spacing = 20
            stack.distribution = .fill
            stack.alignment = .fill
            stack.translatesAutoresizingMaskIntoConstraints = false
            stack.isLayoutMarginsRelativeArrangement = false

           return stack
        }( )
        @objc func showOrHideTapped() {
            self.delegate.onTapButton(0, type: TypeCollection.BANNER)
        }
        private func makeLabel(title: String,
                               font: UIFont? = UIFont.boldSystemFont(ofSize: 15),
                               color: UIColor ) -> UILabel {
            let textConfig = UILabel(frame: .zero)
            textConfig.font = font
            textConfig.text = title
            textConfig.textAlignment = .left
            textConfig.numberOfLines = 0
            textConfig.textColor = color
            textConfig.numberOfLines = 0
            textConfig.lineBreakMode = .byWordWrapping
            textConfig.adjustsFontSizeToFitWidth = false
            return textConfig
        }
        init(delegate: HomeViewDelegate) {
            self.delegate = delegate
            super.init(frame: UIScreen.main.bounds)
            self.setupView()
        }
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
}

extension HomeView: CodeView {
    func setupAdditionalConfiguration() {
    }
    func setupConstraints() {
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        bodyViewStack.snp.makeConstraints { make in
            make.leading.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(10)
            make.top.equalTo(contentView.safeAreaLayoutGuide)
        }
        stackViewTitle.snp.makeConstraints { make in
            make.leading.trailing.equalTo(bodyViewStack)
        }
        spotLightView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(bodyViewStack)
            make.height.equalTo(100)
        }
        productView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(bodyViewStack)
            make.height.equalTo(100)
        }
        stackViewBanner.snp.makeConstraints { make in
            make.leading.trailing.equalTo(bodyViewStack)
        }
        stackViewProduct.snp.makeConstraints { make in
            make.leading.trailing.equalTo(bodyViewStack)
        }
        iconTitle.snp.makeConstraints { make in
            make.height.width.equalTo(20)
        }
        titleBannerCash.snp.makeConstraints { make in
            make.height.width.equalTo(30)
        }
        imageBannerCash.snp.makeConstraints { make in
            make.height.equalTo(100)
        }
    }
    func buildViewHierrachy() {
        addSubview( contentView )
        contentView.addSubview( bodyViewStack )
    }
}

extension HomeView: UICollectionViewDelegate {
     func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
         let index = indexPath.item
         guard let type = TypeCollection.init(rawValue: collectionView.tag) else {
             return
         }
         self.delegate.onTapButton(index, type: type)
         ConsoleLog.normal(message: "click item collection -> \(index) tag -> \(type)" )
     }
}
