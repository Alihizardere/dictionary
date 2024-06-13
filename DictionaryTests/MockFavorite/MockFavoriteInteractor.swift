//
//  MockFavoriteInteractor.swift
//  DictionaryTests
//
//  Created by alihizardere on 13.06.2024.
//

import Foundation
@testable import Dictionary

final class MockFavoriteInteractor: FavoriteInteractorProtocol {

  var invokedFetchSavedFavoriteWords = false
  var invokedDeleteWord = false
  var mockSavedFavoriteWords: [String] = []

  func fetchSavedFavoriteWords() {
    invokedFetchSavedFavoriteWords = true
  }

  func deleteWord(at indexPath: IndexPath) {
    invokedDeleteWord = true
  }
}
