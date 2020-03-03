//
//  ServiceType.swift
//  AllAboutBlues
//
//  Created by Soohan Lee on 2020/03/02.
//  Copyright © 2020 Soohan Lee. All rights reserved.
//

import Foundation

protocol ServiceType {
  func fetchFixtureData()
  
  func fetchTeamData(teamID: Int, completionHandler: @escaping (Result<Team, ServiceError>) -> Void)
}
