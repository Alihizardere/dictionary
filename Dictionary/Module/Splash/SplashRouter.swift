//
//  SplashRouter.swift
//  Dictionary
//
//  Created by alihizardere on 6.06.2024.
//

import UIKit

enum SplashRoutes {
  case home
}

protocol SplashRouterProtocol {
  func navigate(_ route: SplashRoutes)
}

final class SplashRouter {

  weak var viewController: SplashViewController?

  static func createModule() -> SplashViewController {
    let view = SplashViewController()
    let interactor = SplashInteractor()
    let router = SplashRouter()
    let presenter = SplashPresenter(
      view: view,
      router: router,
      interactor: interactor
    )

    view.presenter = presenter
    interactor.output = presenter
    router.viewController = view
    return view
  }
}

extension SplashRouter: SplashRouterProtocol {
  func navigate(_ route: SplashRoutes) {
    switch route {
    case .home:
      guard let window = viewController?.view.window else { return }
      let tabbar = CustomTabBar()
      window.rootViewController = tabbar
    }
  }
}
