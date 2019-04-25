//
//  Fruit.swift
//  Frudder!
//
//  Created by Thomas Pratama Putra on 23/04/19.
//  Copyright © 2019 NA. All rights reserved.
//

import Foundation
import RealmSwift

class Fruit: Object {
    @objc dynamic var fruitID: Int = Int()
    @objc dynamic var fruitName: String = String()
    @objc dynamic var funFacts: String = String()
    @objc dynamic var glucoseContent: Int = Int()
    @objc dynamic var vitaminContent: String = String()
    @objc dynamic var carboContent: Int = Int()
    @objc dynamic var calContent: Int = Int()
    
}
