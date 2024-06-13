//
//  TranslatePresenter.swift
//  Dictionary
//
//  Created by alihizardere on 13.06.2024.
//

import Foundation

protocol TranslatePresenterProtocol {

}

final class TranslatePresenter {

  weak var view: TranslateViewControllerProtocol!
  let interactor: TranslateInteractorProtocol
  let router: TranslateRouter

  init(
    view: TranslateViewControllerProtocol!,
    interactor: TranslateInteractorProtocol,
    router: TranslateRouter
  ) {
    self.view = view
    self.interactor = interactor
    self.router = router
  }  
}

extension TranslatePresenter: TranslatePresenterProtocol {

}

extension TranslatePresenter: TranslateInteractorOutputProtocol {

}
