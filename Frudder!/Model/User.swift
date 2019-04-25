//
//  User.swift
//  Frudder!
//
//  Created by Thomas Pratama Putra on 25/04/19.
//  Copyright © 2019 NA. All rights reserved.
//

import Foundation
import RealmSwift

class User: Object {
    @objc dynamic var toEatID: Int = Int()
    @objc dynamic var fruitIDtoEat: Int = Int()
    @objc dynamic var quantityToEat: Int = Int()
}
