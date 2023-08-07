//
//  ItemDetailController.swift
//  DigioOneFinger
//
//  Created by LEONARDO A SILVEIRA on 05/08/23.
//

import Foundation
import UIKit

class ItemDetailController: ViewController, ViewCodeProtocol {
    typealias CustomView = ItemDetailView
    var item: ItemModel
    
    init(_ item: ItemModel? = nil ){
        self.item = item ?? ItemModel()
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
          return .lightContent
      }
      override func loadView() {
          self.navigationController?.isNavigationBarHidden = false
 
          super.loadView()
          view = ItemDetailView()
          handlerObserver()
      }
      override func viewDidLoad() {
          super.viewDidLoad()
           
           
        
      }
    fileprivate func handlerObserver() {
 
        
        
        let urlImage = self.item.urlImage
        self.customView.itemImage.setImage(imageURL: urlImage)
        self.customView.itemTitle.text = self.item.title
        self.customView.itemDescription.text =  self.item.description
        self.customView.layoutIfNeeded()
        
                                
   }
    
}

 
