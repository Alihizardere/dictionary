//
//  EntryPresenter.swift
//  Dictionary
//
//  Created by alihizardere on 11.06.2024.
//

import Foundation


protocol EntryPresenterProtocol {
  func navigateQuiz()
}

final class EntryPresenter {
  let router: EntryRouterProtocol

  init(router: EntryRouterProtocol) {
    self.router = router
  }
}

extension EntryPresenter: EntryPresenterProtocol {
  func navigateQuiz() {
    self.router.navigate(route: .quiz)
  }
}
