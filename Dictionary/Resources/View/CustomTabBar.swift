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
      title: "Home",
      image: UIImage(systemName: "house"),
      selectedImage: UIImage(systemName: "house.fill")
    )
    vc.tabBarItem = item
    let navController = UINavigationController(rootViewController: vc)
    return navController
  }()

  private lazy var translateVC: UINavigationController = {
    let vc = TranslateRouter.createModule()
    let item = UITabBarItem(
      title: "Translate",
      image: UIImage(systemName: "bubble.left.and.text.bubble.right"),
      selectedImage: UIImage(systemName: "bubble.left.and.text.bubble.right.fill")
    )
    vc.tabBarItem = item
    let navController = UINavigationController(rootViewController: vc)
    return navController
  }()

  private lazy var favoriteVC: UINavigationController = {
    let vc = FavoriteRouter.createModule()
    let item = UITabBarItem(
      title: "Saved",
      image: UIImage(systemName: "bookmark"),
      selectedImage: UIImage(systemName: "bookmark.fill")
    )
    vc.tabBarItem = item
    let navController = UINavigationController(rootViewController: vc)
    return navController
  }()

  private lazy var exerciseVC: UINavigationController = {
    let vc = EntryRouter.createModule()
    let item = UITabBarItem(
      title: "Exercise",
      image: UIImage(systemName: "book.closed"),
      selectedImage: UIImage(systemName: "book.closed.fill")
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
    tabBar.backgroundColor = .main
    tabBar.tintColor = .white
    tabBar.unselectedItemTintColor = .systemGray4
    self.viewControllers = [homeVC, translateVC, favoriteVC, exerciseVC]
  }
}
