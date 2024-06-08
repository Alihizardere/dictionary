//
//  DetailRouter.swift
//  Dictionary
//
//  Created by alihizardere on 8.06.2024.
//

import Foundation

protocol DetailRouterProtocol {

}

final class DetailRouter {
  
  weak var viewController: DetailViewController?

  static func createModule() -> DetailViewController {
    let view = DetailViewController()
    let interactor = DetailInteractor()
    let router = DetailRouter()
    let presenter = DetailPresenter(
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

extension DetailRouter: DetailRouterProtocol {
  
}
