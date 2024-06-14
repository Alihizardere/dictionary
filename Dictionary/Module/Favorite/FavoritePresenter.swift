//
//  FavoritePresenter.swift
//  Dictionary
//
//  Created by alihizardere on 13.06.2024.
//

import Foundation

protocol FavoritePresenterProtocol {
  func viewDidLoad()
  func viewWillAppear()
  func numberOfItems() -> Int
  func cellForRowAt(indexPath: IndexPath) -> String?
  func deleteWord(at indexPath: IndexPath)
}

final class FavoritePresenter {
  
  // MARK: - Properties
  weak var view: FavoriteViewControllerProtocol!
  let interactor: FavoriteInteractorProtocol
  let router: FavoriteRouter
  var favoriteWords = [String]()

  init(
    view: FavoriteViewControllerProtocol!,
    interactor: FavoriteInteractorProtocol,
    router: FavoriteRouter
  ) {
    self.view = view
    self.interactor = interactor
    self.router = router
  }
}

// MARK: - FavoritePresenterProtocols
extension FavoritePresenter: FavoritePresenterProtocol {

  func viewDidLoad() {
    view.setupUI()
  }
  
  func viewWillAppear() {
    fetchSavedFavoriteWords()
    view.reloadData()
  }

  private func fetchSavedFavoriteWords() {
    interactor.fetchSavedFavoriteWords()
  }

  func numberOfItems() -> Int {
    favoriteWords.count
  }

  func cellForRowAt(indexPath: IndexPath) -> String? {
    let word = favoriteWords[indexPath.row]
    return word
  }

  func deleteWord(at indexPath: IndexPath) {
    interactor.deleteWord(at: indexPath)
    favoriteWords.remove(at: indexPath.row)
    view.reloadData()
  }
}

// MARK: - FavoriteInteractorOutputProtocol
extension FavoritePresenter: FavoriteInteractorOutputProtocol {
  func fetchSavedFavoriteWordsOutput(words: [String]) {
    DispatchQueue.main.async {
      self.favoriteWords = words
    }
  }
}
