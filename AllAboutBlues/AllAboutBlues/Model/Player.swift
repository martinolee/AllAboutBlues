//
//  Player.swift
//  AllAboutBlues
//
//  Created by Soohan Lee on 2020/03/01.
//  Copyright © 2020 Soohan Lee. All rights reserved.
//

import Foundation

struct Player {
  var name: String
  var number: UInt8?
  var position: Position
  var nationality: String
  let birthDate: Date
}

extension Player {
  var description: String {
    """
    name: \(name)
    number: \(number ?? 0)
    position: \(position)
    nationality: \(nationality)
    birthDate: \(birthDate)
    """
  }
}
