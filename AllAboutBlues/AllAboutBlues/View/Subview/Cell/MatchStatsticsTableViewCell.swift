//
//  MatchStatsticCell.swift
//  AllAboutBlues
//
//  Created by Soohan Lee on 2020/03/10.
//  Copyright © 2020 Soohan Lee. All rights reserved.
//

import UIKit

class MatchStatsticsTableViewCell: UITableViewCell {
  
  // MARK: - Properties
  
  private let homeStatsticsLabel: UILabel = {
    let label = UILabel()
    
    label.translatesAutoresizingMaskIntoConstraints = false
    
    label.textAlignment = .left
    
    return label
  }()
  
  private let homeStatsticsView: UIView = {
    let view = UIView()
    
    view.translatesAutoresizingMaskIntoConstraints = false
    
    view.backgroundColor = .green
    
    return view
  }()
  
  private lazy var homeStatsticsViewWidth = homeStatsticsView.widthAnchor.constraint(equalTo: homeUnderLineView.widthAnchor, multiplier: 0)
  
  private let homeUnderLineView: UIView = {
    let view = UIView()
    
    view.translatesAutoresizingMaskIntoConstraints = false
    
    view.backgroundColor = .green
    
    return view
  }()
  
  private let statsticsTypeLabel: UILabel = {
    let label = UILabel()
    
    label.translatesAutoresizingMaskIntoConstraints = false
    
    label.textAlignment = .center
    
    return label
  }()
  
  private let awayStatsticsLabel: UILabel = {
    let label = UILabel()
    
    label.translatesAutoresizingMaskIntoConstraints = false
    
    label.textAlignment = .right
    
    return label
  }()
  
  private lazy var awayStatsticsView: UIView = {
    let view = UIView()
    
    view.translatesAutoresizingMaskIntoConstraints = false
    
    view.backgroundColor = .cyan
    
    return view
  }()
  
  private lazy var awayStatsticsViewWidth = awayStatsticsView.widthAnchor.constraint(equalTo: awayUnderLineView.widthAnchor, multiplier: 0)
  
  private let awayUnderLineView: UIView = {
    let view = UIView()
    
    view.translatesAutoresizingMaskIntoConstraints = false
    
    view.backgroundColor = .cyan
    
    return view
  }()
  
  // MARK: - Initializtion
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    configureCell()
    addAllView()
    setupCellAutoLayout()
    setupHomeStatsticLabelAutoLayout()
    setupHomeStatsticViewAutoLayout()
    setupHomeUnderLineViewAutoLayout()
    setupStatsticTypeLabelAutoLayout()
    setupAwayStatsticLabelAutoLayout()
    setupAwayStatsticViewAutoLayout()
    setupAwayUnderLineViewAutoLayout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Configuration
  
  private func configureCell() {
    
  }
  
  // MARK: - Setup UI
  
  private func addAllView() {
    self.addSubview(homeStatsticsLabel)
    self.addSubview(homeStatsticsView)
    self.addSubview(homeUnderLineView)
    self.addSubview(statsticsTypeLabel)
    self.addSubview(awayStatsticsLabel) 
    self.addSubview(awayStatsticsView)
    self.addSubview(awayUnderLineView)
  }
  
  private func setupCellAutoLayout() {
    NSLayoutConstraint.activate([
      self.heightAnchor.constraint(equalToConstant: 44)
    ])
  }
  
  private func setupHomeStatsticLabelAutoLayout() {
    NSLayoutConstraint.activate([
      homeStatsticsLabel.topAnchor     .constraint(equalTo: contentView       .topAnchor),
      homeStatsticsLabel.leadingAnchor .constraint(equalTo: contentView       .leadingAnchor, constant: 8),
      homeStatsticsLabel.trailingAnchor.constraint(equalTo: statsticsTypeLabel.leadingAnchor),
      homeStatsticsLabel.bottomAnchor  .constraint(equalTo: homeStatsticsView .topAnchor),
    ])
  }
  
  private func setupHomeStatsticViewAutoLayout() {
    NSLayoutConstraint.activate([
      homeStatsticsView.trailingAnchor .constraint(equalTo: homeUnderLineView.trailingAnchor),
      homeStatsticsView.bottomAnchor   .constraint(equalTo: homeUnderLineView.topAnchor),
      homeStatsticsViewWidth,
      homeStatsticsView.heightAnchor   .constraint(equalToConstant: 3)
    ])
  }
  
  private func setupHomeUnderLineViewAutoLayout() {
    NSLayoutConstraint.activate([
      homeUnderLineView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      homeUnderLineView.bottomAnchor .constraint(equalTo: contentView.bottomAnchor),
      homeUnderLineView.widthAnchor  .constraint(equalTo: contentView.widthAnchor, multiplier: 0.5),
      homeUnderLineView.heightAnchor .constraint(equalToConstant: 1),
    ])
  }
  
  private func setupStatsticTypeLabelAutoLayout() {
    NSLayoutConstraint.activate([
      statsticsTypeLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
      statsticsTypeLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
    ])
  }
  
  private func setupAwayStatsticLabelAutoLayout() {
    NSLayoutConstraint.activate([
      awayStatsticsLabel.topAnchor     .constraint(equalTo: contentView       .topAnchor),
      awayStatsticsLabel.leadingAnchor .constraint(equalTo: statsticsTypeLabel.trailingAnchor),
      awayStatsticsLabel.trailingAnchor.constraint(equalTo: contentView       .trailingAnchor, constant: -8),
      awayStatsticsLabel.bottomAnchor  .constraint(equalTo: awayStatsticsView .topAnchor),
    ])
  }
  
  private func setupAwayStatsticViewAutoLayout() {
    NSLayoutConstraint.activate([
      awayStatsticsView.leadingAnchor .constraint(equalTo: awayUnderLineView.leadingAnchor),
      awayStatsticsView.bottomAnchor  .constraint(equalTo: awayUnderLineView.topAnchor),
      awayStatsticsViewWidth,
      awayStatsticsView.heightAnchor  .constraint(equalToConstant: 3)
    ])
  }
  
  private func setupAwayUnderLineViewAutoLayout() {
    NSLayoutConstraint.activate([
      awayUnderLineView.trailingAnchor.constraint(equalTo: contentView      .trailingAnchor),
      awayUnderLineView.bottomAnchor  .constraint(equalTo: homeUnderLineView.bottomAnchor),
      awayUnderLineView.heightAnchor  .constraint(equalTo: homeUnderLineView.heightAnchor),
      awayUnderLineView.widthAnchor   .constraint(equalTo: homeUnderLineView.widthAnchor),
    ])
  }
  
  // MARK: - Element Control
  
  func configure(statsticsType: String, homeValueText: String, awayValueText: String, homeViewWidth: CGFloat, awayViewWidth: CGFloat) {
    statsticsTypeLabel.text = statsticsType
    homeStatsticsLabel.text = homeValueText
    awayStatsticsLabel.text = awayValueText
    homeStatsticsViewWidth = homeStatsticsView.widthAnchor.constraint(equalTo: homeUnderLineView.widthAnchor, multiplier: homeViewWidth)
    awayStatsticsViewWidth = awayStatsticsView.widthAnchor.constraint(equalTo: awayUnderLineView.widthAnchor, multiplier: awayViewWidth)
    homeStatsticsViewWidth.isActive = true
    awayStatsticsViewWidth.isActive = true
  }
  
}
