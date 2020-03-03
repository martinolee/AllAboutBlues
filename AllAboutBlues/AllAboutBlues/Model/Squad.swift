//
//  Squad.swift
//  AllAboutBlues
//
//  Created by Soohan Lee on 2020/03/02.
//  Copyright © 2020 Soohan Lee. All rights reserved.
//

import Foundation

struct Squad {
  var coach: Coach
  var players: [Player]
}

extension Squad {
  var description: String {
    """
    coach: \(coach)
    players: \(players)
    """
  }
}
