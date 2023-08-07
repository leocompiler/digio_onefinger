//
//  EntityMarketProducts.swift
//  DigioOneFinger
//
//  Created by LEONARDO A SILVEIRA on 02/08/23.
//

import Foundation


class EntityMarketProducts: CommonModel {
    
    var products: [EntityProduct]?
    var spotlight: [EntitySpotlight]?
    var cash: EntityCash?
    
    
    func getUrlProduct() -> [String] {
        var urls:[String] = []
        products?.forEach({ product in
            if let url = product.url {
                urls.append(url)
            }
        })
        
        return urls
    }
    func getUrlSpotLight() -> [String] {
        var urls:[String] = []
        spotlight?.forEach({ product in
            if let url = product.url {
                urls.append(url)
            }
        })
        
        return urls
    }
}
