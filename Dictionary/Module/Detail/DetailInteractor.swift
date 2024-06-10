//
//  DetailInteractor.swift
//  Dictionary
//
//  Created by alihizardere on 8.06.2024.
//

import Foundation

fileprivate var wordService: WordServiceProtocol = API()
typealias SynonymWordResult = Result<[Synonym], NetworkError>
typealias WordResult = Result<[WordResponse], NetworkError>


protocol DetailInteractorProtocol {
  func fetchSynonymWords(word: String)
  func fetchSynonymDetail(for synonym: String)
}

protocol DetailInteractorOutputProtocol {
  func fetchSynonymWordsOutput(result: SynonymWordResult)
  func fetchSynonymDetailOutput(result: WordResult)
}

final class DetailInteractor {
  var output: DetailInteractorOutputProtocol?
}

extension DetailInteractor: DetailInteractorProtocol {

  func fetchSynonymWords(word: String) {
    wordService.fetchSynonymWord(word: word) { [weak self] result in
      guard let self else { return }
      DispatchQueue.main.async {
        self.output?.fetchSynonymWordsOutput(result: result)
      }
    }
  }

  func fetchSynonymDetail(for synonym: String) {
    wordService.fetchWord(word: synonym) { [weak self] result in
      guard let self else { return }
      DispatchQueue.main.async {
        self.output?.fetchSynonymDetailOutput(result: result)
      }
    }
  }

}
