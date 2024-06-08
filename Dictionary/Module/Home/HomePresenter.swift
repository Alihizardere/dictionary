//
//  HomePresenter.swift
//  Dictionary
//
//  Created by alihizardere on 6.06.2024.
//

import Foundation

protocol HomePresenterProtocol {
  func didSelectWord(word: String)
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
  func didSelectWord(word: String) {
    fethWord(word: word)
  }

  private func fethWord(word: String) {
    interactor.fetchWord(word: word)
  }
}

extension HomePresenter: HomeInteractorOutputProtocol {
  func fetchWordOutput(result: WordSourceResult) {
    switch result {
    case .success(let word):
      DispatchQueue.main.async {
        self.router.navigate(.detail(word: word))
      }
    case .failure(let error):
      print(error.localizedDescription)
    }
  }
}
