//
//  MockInteractor.swift
//  DictionaryTests
//
//  Created by alihizardere on 13.06.2024.
//

import Foundation
@testable import Dictionary

final class MockHomeInteractor: HomeInteractorProtocol {
  
  var invokedFetchWord = false
  var invokedFetchWordCount = 0
  var invokedFetchWordParameters: (word: String, Void)?

  var invokedFetchSavedWords = false
  var invokedFetchSavedWordsCount = 0

  var invokedDeleteWord = false
  var invokedDeleteWordCount = 0
  var invokedDeleteWordParameters: (indexPath: IndexPath, Void)?

  func fetchWord(word: String) {
    invokedFetchWord = true
    invokedFetchWordCount += 1
    invokedFetchWordParameters = (word, ())
  }

  func fetchSavedWords() {
    invokedFetchSavedWords = true
    invokedFetchSavedWordsCount += 1
  }

  func deleteWord(indexPath: IndexPath) {
    invokedDeleteWord = true
    invokedDeleteWordCount += 1
    invokedDeleteWordParameters = (indexPath, ())
  }
}
