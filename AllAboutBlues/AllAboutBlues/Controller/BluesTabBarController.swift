//
//  BluesTabBarController.swift
//  AllAboutBlues
//
//  Created by Soohan Lee on 2020/03/03.
//  Copyright © 2020 Soohan Lee. All rights reserved.
//

import UIKit

class BluesTabBarController: UITabBarController {
  // MARK: - Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupTabBar()
  }
  
  private func setupTabBar() {
    let fixtureViewController = UINavigationController(rootViewController: FixtureViewController())
    fixtureViewController.title = "Fixture"
    
    let teamViewController = UINavigationController(rootViewController: TeamViewController())
    teamViewController.title = "Team"
    
    viewControllers = [fixtureViewController, teamViewController]
  }
}
