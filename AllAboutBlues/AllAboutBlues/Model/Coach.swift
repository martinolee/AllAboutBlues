//
//  Coach.swift
//  AllAboutBlues
//
//  Created by Soohan Lee on 2020/03/01.
//  Copyright © 2020 Soohan Lee. All rights reserved.
//

import Foundation

struct Coach {
  var name: String
  var nationality: String
  let birthDate: Date
}

extension Coach {
  var description: String {
    """
    name: \(name)
    nationality: \(nationality)
    birthDate: \(birthDate)
    """
  }
}
