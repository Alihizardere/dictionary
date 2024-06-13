//
//  TranslateRouter.swift
//  Dictionary
//
//  Created by alihizardere on 13.06.2024.
//

import Foundation

enum TranslateRoutes {

}

protocol TranslateRouterProtocol {

}

final class TranslateRouter {

  weak var viewController: TranslateViewController?

  static func createModule() -> TranslateViewController {
    let view = TranslateViewController()
    let interactor = TranslateInteractor()
    let router = TranslateRouter()
    let presenter = TranslatePresenter(
      view: view,
      interactor: interactor,
      router: router
    )

    view.presenter = presenter
    interactor.output = presenter
    router.viewController = view
    return view
  }

}

extension TranslateRouter: TranslateRouterProtocol {

}
