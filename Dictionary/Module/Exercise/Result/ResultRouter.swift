//
//  ResultRouter.swift
//  Dictionary
//
//  Created by alihizardere on 11.06.2024.
//

import Foundation

enum ResultRoutes {
  case playAgain
  case backToHome
}

protocol ResultRouterProtocol {
  func navigate(route: ResultRoutes)
}

final class ResultRouter {
  
  weak var viewController: ResultViewController?

  static func createModule() -> ResultViewController {
    let view = ResultViewController()
    let router = ResultRouter()
    let presenter = ResultPresenter(view: view, router: router)
    view.presenter = presenter
    router.viewController = view
    return view
  }
}

extension ResultRouter: ResultRouterProtocol {
  func navigate(route: ResultRoutes) {
    switch route {
    case .playAgain:
      let entryVC = EntryRouter.createModule()
      viewController?.navigationController?.pushViewController(entryVC, animated: true)
    case .backToHome:
      let tabbar = CustomTabBar()
      viewController?.navigationController?.pushViewController(tabbar, animated: true)
    }
  }
}
