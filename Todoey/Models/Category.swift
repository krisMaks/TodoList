//
//  Category.swift
//  Todoey
//
//  Created by Кристина Максимова on 01.04.2022.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var colour: String = ""
    let items = List<Item>()
}

