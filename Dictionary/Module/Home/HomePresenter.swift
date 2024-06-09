//
//  HomePresenter.swift
//  Dictionary
//
//  Created by alihizardere on 6.06.2024.
//

import Foundation

protocol HomePresenterProtocol {
  func viewDidLoad()
  func viewWillAppear()
  func wordSearched(word: String)
  func fetchSavedWords()
  func numberOfItems() -> Int
  func didSelectRowAt(_ indexPath: IndexPath)
  func word(indexPath: IndexPath) -> String?
  func deleteWord(at indexPath: IndexPath)
}

final class HomePresenter {
  weak var view: HomeViewControllerProtocol!
  let router: HomeRouterProtocol
  let interactor: HomeInteractorProtocol

  private var words = [String]()

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

  func viewDidLoad() {
    view.setupDelegates()
  }

  func viewWillAppear() {
    fetchSavedWords()
    view.reloadData()
  }

  func wordSearched(word: String) {
    fetch(word: word)
  }

  func fetchSavedWords() {
    interactor.fetchSavedWords()
  }

  func numberOfItems() -> Int {
    if words.count <= 5 {
     return  words.count
    }
    return 5
  }

  func didSelectRowAt(_ indexPath: IndexPath) {
    let word = words[indexPath.row]
    fetch(word: word)
  }

  func word(indexPath: IndexPath) -> String? {
    words[indexPath.row]
  }

  func deleteWord(at indexPath: IndexPath) {
    interactor.deleteWord(indexPath: indexPath)
    words.remove(at: indexPath.row)
    view.reloadData()
  }

  private func fetch(word: String) {
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

  func fetchSavedWordsOutput(words: [String]) {
    DispatchQueue.main.async {
      self.words = words
    }
  }
}
