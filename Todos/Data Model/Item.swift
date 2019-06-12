//
//  Item.swift
//  Todos
//
//  Created by Daniel Drennan on 12/06/2019.
//  Copyright © 2019 Daniel Drennan. All rights reserved.
//

import Foundation

// for NSCoder added : Encodable, Decodable (or just Codable frmo swift 4)
//
class Item : Codable {
  var sTitle : String = ""
  var bDone : Bool = false

}

