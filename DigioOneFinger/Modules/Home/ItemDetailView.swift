//
//  HomeView.swift
//  DigioOneFinger
//
//  Created by LEONARDO A SILVEIRA on 01/08/23.
//

import Foundation
import UIKit
import SnapKit

 
class ItemDetailView: LayoutTools  {
 
 
        private lazy var contentView: UIView = {
            let view = UIView()
            view.backgroundColor = .white
            return view
        }()
    
        lazy var scrollView: UIScrollView = {
            let scrollView = UIScrollView()
            scrollView.translatesAutoresizingMaskIntoConstraints = false
            scrollView.alwaysBounceHorizontal = false
            scrollView.showsHorizontalScrollIndicator = false
            scrollView.bounces = false
            return scrollView
        }()
 
        lazy var itemImage : UIImageView = {
            let img = UIImageView()
            img.image = UIImage( named: "")
            img.contentMode =  .scaleToFill //.scaleAspectFill
            img.clipsToBounds = true;
            img.layer.cornerRadius = 8;
            img.backgroundColor = .red
            return img
        }()
        

        lazy var itemTitle: UILabel = makeLabel( title: "home_detail_item_title".localized,
                                                  font: UIFont(name: boldDMSans, size: 24),
                                                  color: UIColor.black)
        

        
        
        lazy var itemDescription: UILabel = makeLabel(title: "home_detail_item_description".localized,
                                                          font: UIFont(name: boldDMSans, size: 18),
                                                          color: UIColor.black)
        
     
         
          
        
        private lazy var bodyViewStack: UIStackView = {
            let views: [UIView] = [itemImage,itemTitle,itemDescription]
            let stack = UIStackView( arrangedSubviews: views)
            stack.axis = .vertical
            stack.spacing = 10
            stack.distribution = .fill
            stack.alignment = .center
            return stack
        }()
        
       private func makeLabel(title: String, font: UIFont? = UIFont.boldSystemFont(ofSize: 15), color: UIColor ) -> UILabel {
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
       
 
        init() {
            super.init(frame: .zero)
            self.setupView()
                          
        }
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
 
}

extension ItemDetailView: CodeView {
    func setupAdditionalConfiguration() {
        self.backgroundColor = .white
        self.scrollView.updateContentView()
    }
    func setupConstraints() {
        contentView.snp.makeConstraints{ make in
            make.leading.trailing.equalToSuperview()
            make.top.equalToSuperview().inset(-20)
            make.bottom.equalToSuperview()
        }
        bodyViewStack.snp.makeConstraints{ make in
            make.leading.trailing.equalTo(contentView).inset(10)
        }
        scrollView.snp.makeConstraints{ make in
            make.edges.equalToSuperview()
        }

    }
    func buildViewHierrachy() {
        addSubview( contentView )
        contentView.addSubview(scrollView)
        scrollView.addSubview( bodyViewStack )
        
        
        

    }
}


 


 

