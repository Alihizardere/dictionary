//
//  HomeRouter.swift
//  Dictionary
//
//  Created by alihizardere on 6.06.2024.
//

import Foundation

protocol HomeRouterProtocol {

}

final class HomeRouter {
  weak var viewController: HomeViewController?

  static func createModule() -> HomeViewController {
    let view = HomeViewController()
    let interactor = HomeInteractor()
    let router = HomeRouter()
    let presenter = HomePresenter(view: view, router: router, interactor: interactor)
    view.presenter = presenter
    interactor.output = presenter
    router.viewController = view
    return view
  }
}

extension HomeRouter: HomeRouterProtocol {
  
}
