//
//  HomeInteractor.swift
//  Dictionary
//
//  Created by alihizardere on 6.06.2024.
//

import Foundation

fileprivate var wordService: WordServiceProtocol = API()
typealias WordSourceResult = Result<[WordResponse], NetworkError>

protocol HomeInteractorProtocol {
  func fetchWord(word: String)
}

protocol HomeInteractorOutputProtocol {
  func fetchWordOutput(result: WordSourceResult)
}

final class HomeInteractor {
  var output: HomeInteractorOutputProtocol?
}

extension HomeInteractor: HomeInteractorProtocol {
  func fetchWord(word: String) {
    wordService.fetchWord(word: word) { [weak self] result in
      guard let self else { return }
      self.output?.fetchWordOutput(result: result)
    }
  }
}
