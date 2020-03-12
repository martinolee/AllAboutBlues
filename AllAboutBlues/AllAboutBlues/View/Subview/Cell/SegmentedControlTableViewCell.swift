//
//  SegmentedControlCell.swift
//  AllAboutBlues
//
//  Created by Soohan Lee on 2020/03/12.
//  Copyright © 2020 Soohan Lee. All rights reserved.
//

import UIKit

protocol SegmentedControlTableViewCellDelegate {
  func whenSegmentedControlDidChangeValue(segmentedControl: UISegmentedControl, selectedSegmentIndex: Int)
}

class SegmentedControlTableViewCell: UITableViewCell {
  
  // MARK: - Properties
  
  var delegate: SegmentedControlTableViewCellDelegate?
  
  private lazy var segmentedControl: UISegmentedControl = {
    let segmentedControl = UISegmentedControl(items: ["Home Team", "Away Team"])
    
    segmentedControl.translatesAutoresizingMaskIntoConstraints = false
    
    segmentedControl.addTarget(self, action: #selector(whenSegmentedControlDidChangeValue(sender:)), for: .valueChanged)
    
    segmentedControl.selectedSegmentIndex = 0
    
    return segmentedControl
  }()
  
  // MARK: - Initializtion
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    configureCell()
    addAllView()
    setupCellAutoLayout()
    setupSegmentedControlAutoLayout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Configuration
  
  private func configureCell() {
    
  }
  
  // MARK: - Setup UI
  
  private func addAllView() {
    self.addSubview(segmentedControl)
  }
  
  private func setupCellAutoLayout() {
    NSLayoutConstraint.activate([
      self.heightAnchor.constraint(equalToConstant: 44),
    ])
  }
  
  private func setupSegmentedControlAutoLayout() {
    NSLayoutConstraint.activate([
      segmentedControl.topAnchor     .constraint(equalTo: contentView.topAnchor,      constant:  8),
      segmentedControl.leadingAnchor .constraint(equalTo: contentView.leadingAnchor,  constant:  8),
      segmentedControl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
      segmentedControl.bottomAnchor  .constraint(equalTo: contentView.bottomAnchor,   constant: -8),
    ])
  }
  
  // MARK: - Action Handler
  
  @objc
  private func whenSegmentedControlDidChangeValue(sender: UISegmentedControl) {
    delegate?.whenSegmentedControlDidChangeValue(segmentedControl: sender, selectedSegmentIndex: sender.selectedSegmentIndex)
  }
  
  // MARK: - Element Control
  
  func setSegmentedControl(items: [String]) {
    segmentedControl.removeAllSegments()
    for item in items {
      segmentedControl.insertSegment(withTitle: item, at: segmentedControl.numberOfSegments, animated: false)
    }
  }
  
  func setSelectedSegmentedControlIndex(_ selectedSegmentIndex: Int) { segmentedControl.selectedSegmentIndex = selectedSegmentIndex }
  
}
