//
//  TeamViewController.swift
//  AllAboutBlues
//
//  Created by Soohan Lee on 2020/03/01.
//  Copyright © 2020 Soohan Lee. All rights reserved.
//

import UIKit

class TeamViewController: UIViewController {
  
  // MARK: - Properties
  
  private var teamViewModel: TeamViewModel?
  
  private lazy var teamView: TeamView = {
    let view = TeamView()
    
    view.delegate = self
    
    return view
  }()
  
  private let service: ServiceType = Service()
  
  // MARK: - Life Cycle
  
  override func loadView() {
    view = teamView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    service.fetchTeamData(teamID: 61) { [weak self]  result in
      switch result {
      case .success(let team):
        self?.teamViewModel = TeamViewModel(team: team)
        DispatchQueue.main.sync {
          self?.teamView.reloadSquadTableViewData()
        }
      case .failure(let error):
        print(error)
      }
    }
  }
  
  // MARK: - Configuration
  
}

extension TeamViewController: TeamViewDelegate {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    teamViewModel?.team.squad.players.count ?? 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeue(SquadTableViewCell.self)
    guard let player = teamViewModel?.team.squad.players[indexPath.row] else { return UITableViewCell() }
    
    cell.textLabel?.text = player.name
    
    return cell
  }
  
}
