//
//  FixtureViewController.swift
//  AllAboutBlues
//
//  Created by Soohan Lee on 2020/03/01.
//  Copyright © 2020 Soohan Lee. All rights reserved.
//

import UIKit

class FixtureViewController: UIViewController {
  
  // MARK: - Properties
  
  private lazy var fixtureView: FixtureView = {
    let view = FixtureView()
    
    view.delegate = self
    
    return view
  }()
  
  // MARK: - Life Cycle
  
  override func loadView() {
    view = fixtureView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
  }
  
  // MARK: - Configuration
  
}

extension FixtureViewController: FixtureViewDelegate {
  
}
