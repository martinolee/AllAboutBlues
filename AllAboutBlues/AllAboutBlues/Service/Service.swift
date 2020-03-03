//
//  Service.swift
//  AllAboutBlues
//
//  Created by Soohan Lee on 2020/03/02.
//  Copyright © 2020 Soohan Lee. All rights reserved.
//

import UIKit

class Service: ServiceType {
  private let baseURL = "https://api.football-data.org"
  private let authToken = ""
  
  private func constructURLRequest(path: String) -> URLRequest? {
    var urlComp = URLComponents(string: baseURL)
    
    urlComp?.path = path
    
    guard let url = urlComp?.url else { return nil }
    
    var urlRequest = URLRequest(url: url)
//    urlRequest.addValue(authToken, forHTTPHeaderField: "X-Auth-Token")
    return urlRequest
  }
  
  func fetchFixtureData() {
    
  }
  
  func fetchTeamData(teamID: Int, completionHandler: @escaping (Result<Team, ServiceError>) -> Void) {
    guard let urlRequest = constructURLRequest(path: "/v2/teams/\(teamID)") else { return }
    
    let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
//      guard error == nil else { return completionHandler(.failure(.clientError)) }
//      guard let header = response as? HTTPURLResponse,
//        (200..<300) ~= header.statusCode
//        else { return completionHandler(.failure(.invalidStatusCode)) }
//      guard let data = data else { return completionHandler(.failure(.noData)) }
      
      guard
        let jsonData = try? JSONSerialization.jsonObject(with: dummy) as? [String: Any],
        let name = jsonData["name"] as? String,
        let shortName = jsonData["tla"] as? String,
        let stadium = jsonData["venue"] as? String,
        let foundingDate = jsonData["founded"] as? Int,
        let tempSquad = jsonData["squad"] as? [[String: Any]],
        let strLogoURL = jsonData["crestUrl"] as? String
        else { return completionHandler(.failure(.invalidFormat)) }
      var squad: Squad!
      var coach: Coach!
      var players = [Player]()
      
      for person in tempSquad {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        guard
          let role = person["role"] as? String,
          let name = person["name"] as? String,
          let nationality = person["nationality"] as? String,
          let strBirthDate = person["dateOfBirth"] as? String,
          let birthDate = dateFormatter.date(from: strBirthDate)
        else { return completionHandler(.failure(.invalidFormat)) }
        
        if role == "PLAYER" {
          guard
            let strPosition = person["position"] as? String
          else { return completionHandler(.failure(.invalidFormat)) }
          let number = person["shirtNumber"] as? UInt8
          var position: Position!
          
          switch strPosition {
          case "Goalkeeper": position = .goalKeeper
          case "Defender": position = .defender
          case "Midfielder": position = .midfielder
          case "Attacker": position = .forward
          default: position = .none
          }
          
          players.append(Player(name: name, number: number, position: position, nationality: nationality, birthDate: birthDate))
        } else {
          coach = Coach(name: name, nationality: nationality, birthDate: birthDate)
        }
      }
      
      squad = Squad(coach: coach, players: players)
      
      guard
        let logoURL = URL(string: "https://media.api-sports.io/teams/49.png"),
        let logoData = try? Data(contentsOf: logoURL),
        let logo = UIImage(data: logoData)
      else { return completionHandler(.failure(.noData)) }
      
      let team = Team(name: name, shortName: shortName, stadium: stadium, squad: squad, logo: logo, foundingDate: foundingDate)
      completionHandler(.success(team))
    }
    task.resume()
  }
}
