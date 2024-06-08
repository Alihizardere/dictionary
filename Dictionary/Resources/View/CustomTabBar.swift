//
//  CustomTabBar.swift
//  Dictionary
//
//  Created by alihizardere on 6.06.2024.
//

import UIKit

class CustomTabBar: UITabBarController {
  override func viewDidLoad() {
    super.viewDidLoad()
    setupTabBar()
  }

  private func setupTabBar() {

    let homeVC = HomeViewController(nibName: "HomeViewController", bundle: nil)
    homeVC.tabBarItem = UITabBarItem(tabBarSystemItem: .history, tag: 0)

    let secondVC = SecondViewController(nibName: "SecondViewController", bundle: nil)
    secondVC.tabBarItem = UITabBarItem(tabBarSystemItem: .more, tag: 1)

    self.viewControllers = [homeVC, secondVC]
  }
}
