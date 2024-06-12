//
//  QuizRouter.swift
//  Dictionary
//
//  Created by alihizardere on 11.06.2024.
//

import Foundation

enum QuizRoutes {
  case result(score: Int)
  case backToTop
}

protocol QuizRouterProtocol {
  func navigate(route: QuizRoutes)
}

final class QuizRouter {

  weak var viewController: QuizViewController?

  static func createModule() -> QuizViewController {
    let view = QuizViewController()

    let router = QuizRouter()
    let presenter = QuizPresenter(
      view: view,
      router: router
    )
    view.presenter = presenter
    router.viewController = view
    return view
  }
}

extension QuizRouter: QuizRouterProtocol {
  func navigate(route: QuizRoutes) {
    switch route {
    case .result(let score):
      let resultVC = ResultRouter.createModule()
      resultVC.totalScore = score 
      viewController?.navigationController?.pushViewController(resultVC, animated: true)
    case .backToTop:
      let tabbar = CustomTabBar()
      viewController?.navigationController?.pushViewController(tabbar, animated: false)
    }
  }
}
