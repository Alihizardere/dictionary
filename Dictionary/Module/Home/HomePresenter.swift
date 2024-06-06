//
//  HomePresenter.swift
//  Dictionary
//
//  Created by alihizardere on 6.06.2024.
//

import Foundation

protocol HomePresenterProtocol {

}

final class HomePresenter {
  weak var view: HomeViewControllerProtocol!
  let router: HomeRouterProtocol
  let interactor: HomeInteractorProtocol

  init(
    view: HomeViewControllerProtocol!,
    router: HomeRouterProtocol,
    interactor: HomeInteractorProtocol
  ) {
    self.view = view
    self.router = router
    self.interactor = interactor
  }
}

extension HomePresenter: HomePresenterProtocol {
  
}

extension HomePresenter: HomeInteractorOutputProtocol {
  
}
