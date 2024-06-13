//
//  FavoriteRouter.swift
//  Dictionary
//
//  Created by alihizardere on 13.06.2024.
//

import Foundation
protocol FavoriteRouterProtocol {

}

final class FavoriteRouter {

  weak var viewController: FavoriteViewController?

  static func createModule() -> FavoriteViewController {
    let view = FavoriteViewController()
    let interactor = FavoriteInteractor()
    let router = FavoriteRouter()
    let presenter = FavoritePresenter(view: view, interactor: interactor, router: router)

    view.presenter = presenter
    interactor.output = presenter
    router.viewController = view
    return view
  }
}

extension FavoriteRouter: FavoriteRouterProtocol {

}
