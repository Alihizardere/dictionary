//
//  EntryRouter.swift
//  Dictionary
//
//  Created by alihizardere on 11.06.2024.
//

import Foundation

enum EntryRoutes {
  case quiz
}

protocol EntryRouterProtocol {
  func navigate(route: EntryRoutes)
}

final class EntryRouter {

  weak var viewController: EntryViewController?

  static func createModule() -> EntryViewController {
    let view = EntryViewController()
    let router = EntryRouter()
    let presenter = EntryPresenter(router: router)
    view.presenter = presenter
    router.viewController = view
    return view
  }
}

extension EntryRouter: EntryRouterProtocol {
  func navigate(route: EntryRoutes) {
    switch route {
    case .quiz:
      let quizVC = QuizRouter.createModule()
      viewController?.navigationController?.pushViewController(quizVC, animated: true)
    }
  }
}
