//
//  MatchDetailViewController.swift
//  AllAboutBlues
//
//  Created by Soohan Lee on 2020/03/07.
//  Copyright © 2020 Soohan Lee. All rights reserved.
//

import UIKit

class MatchDetailViewController: UIViewController {
  
  // MARK: - Properties
  
  private lazy var lineups = [Lineup]()
  private lazy var matchStatisticses = [MatchStatistics]()
  
  private lazy var matchDetailView: MatchDetailView = {
    let view = MatchDetailView()
    
    view.delegate = self
    
    return view
  }()
  
  private let service = Service.shared
  
  private var matchID: UInt?
  
  private var selectedSegmentIndex = 0
  
  // MARK: - Life Cycle
  
  override func loadView() {
    view = matchDetailView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    fetchLineupData()
    fetchMatchStatisticsData()
  }
  
  // MARK: - Configuration
  
  // MARK: - Data Passing
  
  private func fetchLineupData() {
    guard let matchID = matchID else { return }
    service.fetchLineupData(matchID: matchID) { [weak self] result in
      switch result {
      case .success(let lineups):
        self?.lineups = lineups
        
        DispatchQueue.main.sync {
          self?.matchDetailView.reloadLineupTableViewData()
        }
      case .failure(let error):
        print(error)
      }
    }
  }
  
  private func fetchMatchStatisticsData() {
    guard let matchID = matchID else { return }
    service.fetchMatchStatistics(matchID: matchID) { [weak self] result in
      switch result {
      case .success(let matchStatisticses):
        self?.matchStatisticses = matchStatisticses
        
        DispatchQueue.main.sync {
          self?.matchDetailView.reloadMatchStatsticsTableView()
        }
      case .failure(let error):
        print(error)
      }
    }
  }
  
  func setMatchID(_ id: UInt) { matchID = id }
  
}

// MARK: - Table View Data Source

extension MatchDetailViewController: MatchDetailViewDelegate {
  
  func numberOfLineupTableViewSections(in tableView: UITableView) -> Int {
    guard let lineup = lineups.first else { return 0 }
    
    return ["selecting team", lineup.startPlayers, lineup.coach, lineup.substitutes].count
  }
  
  func lineupTableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    var sectionTitle: String?
    
    let lineup: Lineup!
    
    if selectedSegmentIndex == 0 {
      lineup = lineups.first!
    } else {
      lineup = lineups.last!
    }
    
    switch section {
    case 0:  sectionTitle = nil
    case 1:  sectionTitle = lineup.formation
    case 2:  sectionTitle = "Coach"
    case 3:  sectionTitle = "Substitutes"
    default: sectionTitle = nil
    }
    
    return sectionTitle
  }
  
  func lineupTableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    var numberOfRowsInSection: Int!
    
    let lineup: Lineup!
    
    if selectedSegmentIndex == 0 {
      lineup = lineups.first!
    } else {
      lineup = lineups.last!
    }
    
    let formation = lineup.formation.split(separator: "-")
    
    switch section {
    case 0: numberOfRowsInSection = 1
    case 1: numberOfRowsInSection = lineup.startPlayers.count   // numberOfRowsInSection = formation.count + 1
    case 2: numberOfRowsInSection = [lineup.coach].count
    case 3: numberOfRowsInSection = lineup.substitutes.count
    default: break
    }
    
    return numberOfRowsInSection
  }
  
  func lineupTableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeue(LineupTableViewCell.self)
    
    let lineup: Lineup!
    
    if selectedSegmentIndex == 0 {
      lineup = lineups.first!
    } else {
      lineup = lineups.last!
    }
    
    switch indexPath.section {
    case 0:
      let segmentedControlCell = tableView.dequeue(SegmentedControlTableViewCell.self)
      
      segmentedControlCell.delegate = self
      
      segmentedControlCell.setSegmentedControl(items: [lineups.first!.teamName, lineups.last!.teamName])
      
      segmentedControlCell.setSelectedSegmentedControlIndex(selectedSegmentIndex)
      
      return segmentedControlCell
    case 1:
//      var formation = lineup.formation.split(separator: "-")
//      formation.insert("1", at: 0)
//      formation.reverse()
//
//      let playersOfLine = Int(formation[indexPath.row]) ?? 0
//
//      for index in 1 ... playersOfLine {
//        let player = lineup.startPlayers[index]
//        let playerView: PlayerView = {
//          let view = PlayerView()
//
//          view.translatesAutoresizingMaskIntoConstraints = true
//
//          NSLayoutConstraint.activate([
//            view.heightAnchor.constraint(equalToConstant: 44),
//          ])
//
//          return view
//        }()
//
//        if #available(iOS 13.0, *) {
//          playerView.configure(playerImage: UIImage(systemName: "person.crop.square.fill")!, playerNumber: player.number, playerName: player.name)
//        } else {
//          // Fallback on earlier versions
//        }
//        cell.removeSubViewFromPlayerStackView()
//        cell.addSubviewForPlayerStackView(playerView)
//      }
      cell.textLabel?.text = lineup.startPlayers.reversed()[indexPath.row].name
    case 2:
      cell.textLabel?.text = lineup.coach.name
    case 3:
      cell.textLabel?.text = lineup.substitutes[indexPath.row].name
    default:
      break
    }
    
    return cell
  }
  
  func numberOfMatchStatsticsTableViewSections(in lineupTableView: UITableView) -> Int {
    1
  }
  
  func matchStatsticsTableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return matchStatisticses.count
  }
  
  func matchStatsticsTableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeue(MatchStatsticsTableViewCell.self)
    let matchStatistics = matchStatisticses[indexPath.row]
    
    var homeMatchStatistics = matchStatistics.detail.home
    var awayMatchStatistics = matchStatistics.detail.away
    
    if homeMatchStatistics.isEmpty {
      homeMatchStatistics = "0"
    }
    
    if awayMatchStatistics.isEmpty {
      awayMatchStatistics = "0"
    }
    
    var homeStatisticsValue = 0
    var awayStatisticsValue = 0
    
    var homeStatisticsPercentageValue: CGFloat = 0
    var awayStatisticsPercentageValue: CGFloat = 0
    
    if matchStatistics.detail.home.contains("%") {
      homeMatchStatistics.remove(at: homeMatchStatistics.index(before: homeMatchStatistics.endIndex))
      awayMatchStatistics.remove(at: awayMatchStatistics.index(before: awayMatchStatistics.endIndex))
      
      homeStatisticsValue = Int(homeMatchStatistics) ?? 0
      awayStatisticsValue = Int(awayMatchStatistics) ?? 0
      
      homeStatisticsPercentageValue = CGFloat(homeStatisticsValue) / CGFloat(100)
      awayStatisticsPercentageValue = CGFloat(awayStatisticsValue) / CGFloat(100)
      
      homeMatchStatistics += "%"
      awayMatchStatistics += "%"
    } else {
      homeStatisticsValue = Int(homeMatchStatistics) ?? 0
      awayStatisticsValue = Int(awayMatchStatistics) ?? 0
      
      if homeStatisticsValue != 0 || awayStatisticsValue != 0 {
        homeStatisticsPercentageValue = CGFloat(homeStatisticsValue) / CGFloat(homeStatisticsValue + awayStatisticsValue)
        awayStatisticsPercentageValue = CGFloat(awayStatisticsValue) / CGFloat(homeStatisticsValue + awayStatisticsValue)
      }
    }
    
    cell.configure(
      statsticsType: matchStatistics.statisticType.rawValue,
      homeValueText: homeMatchStatistics,
      awayValueText: awayMatchStatistics,
      homeViewWidth: homeStatisticsPercentageValue,
      awayViewWidth: awayStatisticsPercentageValue
    )
    
    return cell
  }
  
  func whenInfoSegmentedControl(segmentedControl: UISegmentedControl, selectedIndex: Int) {
    if selectedIndex == 0 {
      matchDetailView.isMatchStatsticsTableViewHidden(true)
      matchDetailView.isLineupTableViewHidden(false)
    } else if selectedIndex == 1 {
      matchDetailView.isLineupTableViewHidden(true)
      matchDetailView.isMatchStatsticsTableViewHidden(false)
    }
  }
}

// MARK: Segmented Control Delegate

extension MatchDetailViewController: SegmentedControlTableViewCellDelegate {
  func whenSegmentedControlDidChangeValue(segmentedControl: UISegmentedControl, selectedSegmentIndex: Int) {
    self.selectedSegmentIndex = selectedSegmentIndex
    matchDetailView.reloadLineupTableViewData()
  }
}
