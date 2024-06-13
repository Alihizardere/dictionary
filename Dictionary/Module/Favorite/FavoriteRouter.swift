//
//  FavoriteRouter.swift
//  Dictionary
//
//  Created by alihizardere on 13.06.2024.
//

import Foundation

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
