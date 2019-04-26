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
    @objc dynamic var fruitDesc: String = String()
    @objc dynamic var totalFat: Int = Int()
    @objc dynamic var sodiumContent: Int = Int()
    @objc dynamic var sugarContent: Int = Int()
    @objc dynamic var vitaminAContent: Int = Int()
    @objc dynamic var vitaminCContent: Int = Int()
    @objc dynamic var calciumContent: Int = Int()
    @objc dynamic var ironContent: Int = Int()
    @objc dynamic var carboContent: Int = Int()
    @objc dynamic var calContent: Int = Int()
    @objc dynamic var caloriesFromFat: Int = Int()
    @objc dynamic var servingPortion: String = String()
}
