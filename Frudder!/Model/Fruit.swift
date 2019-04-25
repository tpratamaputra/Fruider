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
    @objc dynamic var name: String = String()
    @objc dynamic var quantity: Int = 0
}
