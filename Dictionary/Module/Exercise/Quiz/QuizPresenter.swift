//
//  QuizPresenter.swift
//  Dictionary
//
//  Created by alihizardere on 11.06.2024.
//

import Foundation

protocol QuizPresenterProtocol {
  func viewDidLoad()
  func numberOfItems() -> Int
  func cellForItem(indexPath: IndexPath) -> QuizQuestion?
  func goToNextQuestion()
  func answerSelected(isCorrect: Bool)
  func navigateExit()
}

final class QuizPresenter {
  
  // MARK: - Properties
  weak var view: QuizViewControllerProtocol!
  let router: QuizRouterProtocol
  var questions: [QuizQuestion] = MockQuizData.questions
  private var currentIndex = 0
  private var score = 0

  init(
    view: QuizViewControllerProtocol!,
    router: QuizRouterProtocol
  ) {
    self.view = view
    self.router = router
  }
}

// MARK: - QuizPresenterProtocols
extension QuizPresenter: QuizPresenterProtocol {

  func viewDidLoad() {
    view.setupUI()
  }

  func numberOfItems() -> Int {
    questions.count
  }

  func cellForItem(indexPath: IndexPath) -> QuizQuestion? {
    questions[indexPath.row]
  }

  func goToNextQuestion() {
    currentIndex += 1
    if currentIndex >= questions.count {
      router.navigate(route: .result(score: score))
      return
    } else if currentIndex == questions.count - 1 {
      view.setupNextButtonTitle()
    }
    view.skipToNextQuestion(index: currentIndex)
    view.reloadData()
  }

  func answerSelected(isCorrect: Bool) {
    if isCorrect {
      score += 1
    }
  }

  func navigateExit() {
    router.navigate(route: .backToTop)
  }
}
