//
//  DetailPresenter.swift
//  Dictionary
//
//  Created by alihizardere on 8.06.2024.
//

import Foundation

protocol DetailPresenterProtocol {

}

final class DetailPresenter {

  weak var view: DetailViewControllerProtocol!
  let interactor: DetailInteractorProtocol
  let router: DetailRouterProtocol

  init(
    view: DetailViewControllerProtocol!,
    interactor: DetailInteractorProtocol,
    router: DetailRouterProtocol
  ) {
    self.view = view
    self.interactor = interactor
    self.router = router
  }
}

extension DetailPresenter: DetailPresenterProtocol {

}

extension DetailPresenter: DetailInteractorOutputProtocol {

}
