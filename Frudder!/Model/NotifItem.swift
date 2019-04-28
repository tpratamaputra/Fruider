//
//  NotifItem.swift
//  Frudder!
//
//  Created by Thomas Pratama Putra on 27/04/19.
//  Copyright © 2019 NA. All rights reserved.
//

import Foundation

class NotifItem: Codable {
    var name: String = String()
    var isCheck: Bool = false
    var timeInterval: Int = Int()
    var flagFire: Bool = true
}
