//
//  TeamView.swift
//  AllAboutBlues
//
//  Created by Soohan Lee on 2020/03/01.
//  Copyright © 2020 Soohan Lee. All rights reserved.
//

import UIKit

protocol TeamViewDelegate {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
}

class TeamView: UIView {
  
  // MARK: - Properties
  
  var delegate: TeamViewDelegate?
  
  private lazy var squadTableView: UITableView = {
    let tableView = UITableView()
    
    tableView.register(cell: SquadTableViewCell.self)
    
    tableView.dataSource = self
    tableView.delegate = self
    
    tableView.translatesAutoresizingMaskIntoConstraints = false
    
    return tableView
  }()
  
  // MARK: - Initialization
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    addAllViews()
    setupSquadTableViewAutoLayout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Configuration
  
  // MARK: - Setup UI
  
  private func addAllViews() {
    self.addSubview(squadTableView)
  }
  
  private func setupSquadTableViewAutoLayout() {
    NSLayoutConstraint.activate([
      squadTableView.topAnchor     .constraint(equalTo: self.topAnchor),
      squadTableView.leadingAnchor .constraint(equalTo: self.leadingAnchor),
      squadTableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
      squadTableView.bottomAnchor  .constraint(equalTo: self.bottomAnchor),
    ])
  }
  
  // MARK: - Element Control
  
  func reloadSquadTableViewData() { squadTableView.reloadData() }
}

extension TeamView: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    delegate?.tableView(tableView, numberOfRowsInSection: section) ?? 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    delegate?.tableView(tableView, cellForRowAt: indexPath) ?? UITableViewCell()
  }
}

extension TeamView: UITableViewDelegate {
  
}
