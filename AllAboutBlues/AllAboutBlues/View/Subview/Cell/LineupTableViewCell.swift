//
//  LineupTableViewCell.swift
//  AllAboutBlues
//
//  Created by Soohan Lee on 2020/03/10.
//  Copyright © 2020 Soohan Lee. All rights reserved.
//

import UIKit

class LineupTableViewCell: UITableViewCell {
  
  // MARK: - Properties
  
  private let playerStackView: UIStackView = {
    let view = UIStackView()
    
    view.translatesAutoresizingMaskIntoConstraints = false
    
    view.alignment = .fill
    view.distribution = .equalSpacing
    view.axis = .horizontal
    view.spacing = 10
    
    return view
  }()
  
  // MARK: - Initializtion
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    configureCell()
    addAllView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Configuration
  
  private func configureCell() {
    NSLayoutConstraint.activate([
      self.heightAnchor.constraint(equalToConstant: 44),
    ])
  }
  
  // MARK: - Setup UI
  
  private func addAllView() {
    self.addSubview(playerStackView)
  }
  
  private func setupPlayerStackViewAutoLayout() {
    NSLayoutConstraint.activate([
      playerStackView.topAnchor     .constraint(equalTo: contentView.topAnchor),
      playerStackView.leadingAnchor .constraint(equalTo: contentView.leadingAnchor),
      playerStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      playerStackView.bottomAnchor  .constraint(equalTo: contentView.bottomAnchor),
    ])
  }
  
  // MARK: - Element Control
  
  func addSubviewForPlayerStackView(_ playerView: PlayerView) { playerStackView.addArrangedSubview(playerView) }
  
  func removeSubViewFromPlayerStackView() {
    for view in playerStackView.arrangedSubviews {
      playerStackView.removeArrangedSubview(view)
    }
  }
  
}
