//
//  FavoriteInteractor.swift
//  Dictionary
//
//  Created by alihizardere on 13.06.2024.
//

import Foundation

fileprivate var wordRepository: WordRepositoryProtocol = WordRepository()

protocol FavoriteInteractorProtocol {
 func fetchSavedFavoriteWords()
 func deleteWord(at indexPath: IndexPath)
}

protocol FavoriteInteractorOutputProtocol {
  func fetchSavedFavoriteWords(words: [String])
}

final class FavoriteInteractor {
  var output: FavoriteInteractorOutputProtocol?
}

extension FavoriteInteractor: FavoriteInteractorProtocol {
  
  func fetchSavedFavoriteWords() {
    let words =  wordRepository.fetchFavoriteWords()
    self.output?.fetchSavedFavoriteWords(words: words ?? [])
  }

  func deleteWord(at indexPath: IndexPath) {
    wordRepository.deleteFavoriteWord(indexPath: indexPath)
  }

}
