//
//  CustomTabBar.swift
//  Dictionary
//
//  Created by alihizardere on 6.06.2024.
//

import UIKit

class CustomTabBar: UITabBarController {

  // MARK: - Properties
  private lazy var homeVC: UINavigationController = {
    let vc = HomeRouter.createModule()
    let item = UITabBarItem(
      title: "home",
      image: UIImage(systemName: "house"),
      selectedImage: UIImage(systemName: "house.fill")
    )
    vc.tabBarItem = item
    let navController = UINavigationController(rootViewController: vc)
    return navController
  }()

  private lazy var secondVC: UINavigationController = {
    let vc = SecondViewController()
    let item = UITabBarItem(
      title: "Favorites",
      image: UIImage(systemName: "star"),
      selectedImage: UIImage(systemName: "star.fill")
    )
    vc.tabBarItem = item
    let navController = UINavigationController(rootViewController: vc)
    return navController
  }()

  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setupTabBar()
  }

  // MARK: -  Functions
  private func setupTabBar(){
    tabBar.backgroundColor = .orange
    tabBar.tintColor = .white
    tabBar.unselectedItemTintColor = .systemGray4
    self.viewControllers = [homeVC, secondVC]
  }
}
