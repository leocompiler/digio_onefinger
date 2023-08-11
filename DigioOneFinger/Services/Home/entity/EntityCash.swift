//
//  EntityCash.swift
//  DigioOneFinger
//
//  Created by LEONARDO A SILVEIRA on 03/08/23.
//

import Foundation

class EntityCash: CommonModel {
    var title: String?
    var url: String?
    var _description: String?
    override func propertyMapping() -> [(keyInObject: String?, keyInResource: String?)] {
        return [
                (keyInObject: "title", keyInResource: "title"),
                (keyInObject: "url", keyInResource: "bannerURL"),
                (keyInObject: "_description", keyInResource: "description")
        ]
    }
    func getItem() -> ItemModel {
        return ItemModel(title: self.title, urlImage: self.url, description: self._description)
    }
}
