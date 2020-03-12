//
//  MatchDetailView.swift
//  AllAboutBlues
//
//  Created by Soohan Lee on 2020/03/07.
//  Copyright © 2020 Soohan Lee. All rights reserved.
//

import UIKit

protocol MatchDetailViewDelegate {
  func numberOfLineupTableViewSections(in tableView: UITableView) -> Int
  
  func lineupTableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?
  
  func lineupTableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
  
  func lineupTableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
  
  func numberOfMatchStatsticsTableViewSections(in lineupTableView: UITableView) -> Int
  
  func matchStatsticsTableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
  
  func matchStatsticsTableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
  
  func whenInfoSegmentedControl(segmentedControl: UISegmentedControl, selectedIndex: Int)
}

class MatchDetailView: UIView {
  
  // MARK: - Properties
  
  var delegate: MatchDetailViewDelegate?
  
  private lazy var infoSegmentedControl: UISegmentedControl = {
    let segmentedControl = UISegmentedControl(items: ["Lineup", "Statstics"])
    
    segmentedControl.translatesAutoresizingMaskIntoConstraints = false
    
    segmentedControl.addTarget(self, action: #selector(whenInfoSegmentedControl(sender:)), for: .valueChanged)
    
    segmentedControl.selectedSegmentIndex = 0
    
    return segmentedControl
  }()
  
  private lazy var lineupTableView: UITableView = {
    let tableView = UITableView()
    
    tableView.translatesAutoresizingMaskIntoConstraints = false
    
    tableView.register(cell: SegmentedControlTableViewCell.self)
    tableView.register(cell: LineupTableViewCell.self)
    
    tableView.dataSource = self
    
    tableView.showsVerticalScrollIndicator = false
    
    return tableView
  }()
  
  private lazy var matchStatsticsTableView: UITableView = {
    let tableView = UITableView()
    
    tableView.translatesAutoresizingMaskIntoConstraints = false
    
    tableView.register(cell: MatchStatsticsTableViewCell.self)
    
    tableView.dataSource = self
    
    tableView.showsVerticalScrollIndicator = false
    
    return tableView
  }()
  
  // MARK: - Initialization
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    configureView()
    addAllView()
    setupInfoSegmentedControlAutoLayout()
    setupLineupTableViewAutoLayout()
    setupMatchStatsticsTableViewAutoLayout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Configuration
  
  private func configureView() {
    
  }
  
  // MARK: - Setup UI
  
  private func addAllView() {
    self.addSubview(infoSegmentedControl)
    self.addSubview(lineupTableView)
    self.addSubview(matchStatsticsTableView)
    
    bringSubviewToFront(lineupTableView)
  }
  
  private func setupInfoSegmentedControlAutoLayout() {
    NSLayoutConstraint.activate([
      infoSegmentedControl.topAnchor     .constraint(equalTo: safeAreaLayoutGuide    .topAnchor,      constant:  8),
      infoSegmentedControl.leadingAnchor .constraint(equalTo: safeAreaLayoutGuide    .leadingAnchor,  constant:  8),
      infoSegmentedControl.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide    .trailingAnchor, constant: -8),
      infoSegmentedControl.bottomAnchor  .constraint(equalTo: lineupTableView        .topAnchor,      constant: -8),
    ])
  }
  
  private func setupMatchStatsticsTableViewAutoLayout() {
    NSLayoutConstraint.activate([
      lineupTableView.leadingAnchor .constraint(equalTo: self.leadingAnchor),
      lineupTableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
      lineupTableView.bottomAnchor  .constraint(equalTo: self.bottomAnchor),
    ])
  }
  
  private func setupLineupTableViewAutoLayout() {
    NSLayoutConstraint.activate([
      matchStatsticsTableView.topAnchor     .constraint(equalTo: lineupTableView.topAnchor),
      matchStatsticsTableView.leadingAnchor .constraint(equalTo: lineupTableView.leadingAnchor),
      matchStatsticsTableView.trailingAnchor.constraint(equalTo: lineupTableView.trailingAnchor),
      matchStatsticsTableView.bottomAnchor  .constraint(equalTo: lineupTableView.bottomAnchor),
    ])
  }
  
  // MARK: - Action Handler
  
  @objc
  private func whenInfoSegmentedControl(sender: UISegmentedControl) {
    delegate?.whenInfoSegmentedControl(segmentedControl: sender, selectedIndex: sender.selectedSegmentIndex)
  }
  
  // MARK: - Element Control
  
  func reloadLineupTableViewData() { lineupTableView.reloadData() }
  
  func reloadMatchStatsticsTableView() { matchStatsticsTableView.reloadData() }
  
  func isLineupTableViewHidden(_ hidden: Bool) { lineupTableView.isHidden = hidden }
  
  func isMatchStatsticsTableViewHidden(_ hidden: Bool) { matchStatsticsTableView.isHidden = hidden }
  
}

extension MatchDetailView: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    var numberOfSections = 0
    
    if tableView == lineupTableView {
      numberOfSections = delegate?.numberOfLineupTableViewSections(in: tableView) ?? 0
    } else {
      numberOfSections = delegate?.numberOfMatchStatsticsTableViewSections(in: tableView) ?? 0
    }
    
    return numberOfSections
  }
  
  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    var title: String?
    
    if tableView == lineupTableView {
      title = delegate?.lineupTableView(tableView, titleForHeaderInSection: section)
    }
    
    return title
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    let numberOfRowsInSection: Int!
    
    if tableView == lineupTableView {
      numberOfRowsInSection = delegate?.lineupTableView(tableView, numberOfRowsInSection: section) ?? 0
    } else {
      numberOfRowsInSection = delegate?.matchStatsticsTableView(tableView, numberOfRowsInSection: section) ?? 0
    }
    
    return numberOfRowsInSection
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cellForRowAt: UITableViewCell!
    
    if tableView == lineupTableView {
      cellForRowAt = delegate?.lineupTableView(tableView, cellForRowAt: indexPath) ?? UITableViewCell()
    } else {
      cellForRowAt = delegate?.matchStatsticsTableView(tableView, cellForRowAt: indexPath) ?? UITableViewCell()
    }
    
    return cellForRowAt
  }
}
