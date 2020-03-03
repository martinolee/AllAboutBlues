//
//  AppDelegate.swift
//  AllAboutBlues
//
//  Created by Soohan Lee on 2020/02/29.
//  Copyright © 2020 Soohan Lee. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
    setupRootViewController()
    
    return true
  }
  
  fileprivate func setupRootViewController() {
    window = UIWindow(frame: UIScreen.main.bounds)
    
    let rootViewController = TeamViewController()
    
    window?.rootViewController = rootViewController
    window?.makeKeyAndVisible()
  }
  
  private func loadData() {
    let service: ServiceType = Service()
    
    // Chelsea ID is 61
    service.fetchTeamData(teamID: 61) { result in
      DispatchQueue.main.async {
        switch result {
        case .success(let team):
          print(team)
        case .failure(let error):
          print(error)
        }
      }
    }
  }

}
