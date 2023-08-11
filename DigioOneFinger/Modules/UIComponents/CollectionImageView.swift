//
//  ItemListView.swift
//  DigioOneFinger
//
//  Created by LEONARDO A SILVEIRA on 01/08/23.
//

import Foundation
import UIKit


class CollectionImageView: UICollectionView {
    var list: [String]
    var width: Int
    var height: Int
    var icon: UIImage?
    var scallerFit: Bool
    var identfier = CellImageView.identfier
    init( listItens: [String],
          scallerFit: Bool = false,
          identfier: String = "",
          delegate: UICollectionViewDelegate,
          type: TypeCollection,
          width: Int,
          height: Int) {
        self.list = listItens
        self.width = width
        self.height = height
        self.scallerFit = scallerFit
        self.identfier += identfier
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        
        super.init(frame: .zero, collectionViewLayout: layout)
        self.tag = type.rawValue
        self.translatesAutoresizingMaskIntoConstraints = false
        self.register(UINib(nibName: CellImageView.identfier, bundle: nil), forCellWithReuseIdentifier: self.identfier)
        self.delegate = delegate
        self.dataSource = self
        self.alwaysBounceHorizontal = true
        self.showsHorizontalScrollIndicator = false
        self.backgroundColor = setupColor()
        self.reloadData()
        
     }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setupColor() -> UIColor{
        if #available(iOS 13.0, *) {
            return  .secondarySystemBackground
        } else {
            return  .black
        }
    }
    
}
extension CollectionImageView: UICollectionViewDataSource {
    
  
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        ConsoleLog.normal(message: "CollectionView count -> \(list.count) identfier -> \(self.identfier)" )
        return list.count
    }
      
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      
        let url = list[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.identfier, for: indexPath) as! CellImageView
        cell.setupCell(url: url, width,height )
        
        return cell
    }


 }

extension CollectionImageView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

 
