//
//  Team.swift
//  AllAboutBlues
//
//  Created by Soohan Lee on 2020/03/01.
//  Copyright © 2020 Soohan Lee. All rights reserved.
//

import Foundation

struct Team {
  var name: String
  var shortName: String
  var stadium: String
  var squad: Squad
  var logoURL: String
  let foundingDate: Int
}

extension Team {
  var description: String {
    """
    name: \(name)
    shortName: \(shortName)
    stadium: \(stadium)
    squad: \(squad)
    logo: \(logoURL)
    foundingDate: \(foundingDate)
    """
  }
}
