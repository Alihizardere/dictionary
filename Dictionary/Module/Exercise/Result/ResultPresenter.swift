//
//  ResultPresenter.swift
//  Dictionary
//
//  Created by alihizardere on 11.06.2024.
//

import Foundation

protocol ResultPresenterProtocol {
  func viewDidload()
  func setScore(score: Int)
  func playAgain()
  func backToHome()
}

final class ResultPresenter {
  weak var view: ResultViewControllerProtocol!
  let router: ResultRouterProtocol

  init(
    view: ResultViewControllerProtocol!,
    router: ResultRouterProtocol
  ) {
    self.view = view
    self.router = router
  }
}

extension ResultPresenter: ResultPresenterProtocol {
  
  func viewDidload() {
    view.setupUI()
  }
  
  func setScore(score: Int) {
    if score <= 5 {
      view.configureData()
    }
  }

  func playAgain() {
    router.navigate(route: .playAgain)
  }

  func backToHome() {
    router.navigate(route: .backToHome)
  }
}
