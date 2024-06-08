//
//  HomeInteractor.swift
//  Dictionary
//
//  Created by alihizardere on 6.06.2024.
//

import Foundation

fileprivate var wordService: WordServiceProtocol = API()
typealias WordSourceResult = Result<[WordResponse], NetworkError>
fileprivate var wordRepository: WordRepositoryProtocol = WordRepository()

protocol HomeInteractorProtocol {
  func fetchWord(word: String)
  func fetchSavedWords()
  func deleteWord(indexPath: IndexPath)
}

protocol HomeInteractorOutputProtocol {
  func fetchWordOutput(result: WordSourceResult)
  func fetchSavedWordsOutput(words: [String])
}

final class HomeInteractor {
  var output: HomeInteractorOutputProtocol?
}

extension HomeInteractor: HomeInteractorProtocol {

  func fetchWord(word: String) {
    wordService.fetchWord(word: word) { [weak self] result in
      guard let self else { return }
      DispatchQueue.main.async {
        self.output?.fetchWordOutput(result: result)
        wordRepository.saveWord(word: word)
      }
    }
  }

  func fetchSavedWords() {
    let words = wordRepository.fetchWords()
    self.output?.fetchSavedWordsOutput(words: words ?? [])
  }

  func deleteWord(indexPath: IndexPath) {
    wordRepository.deleteWord(indexPath: indexPath)
    fetchSavedWords()
  }
}
