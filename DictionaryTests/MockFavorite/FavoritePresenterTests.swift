//
//  FavoritePresenterTests.swift
//  DictionaryTests
//
//  Created by alihizardere on 13.06.2024.
//

import XCTest
@testable import Dictionary

final class FavoritePresenterTests: XCTestCase {

  var presenter: FavoritePresenter!
  var view: MockFavoriteViewController!
  var interactor: MockFavoriteInteractor!
  var router: FavoriteRouter! 

  override func setUp() {
    super.setUp()

    view = MockFavoriteViewController()
    interactor = MockFavoriteInteractor()
    router = FavoriteRouter()

    presenter = FavoritePresenter(
      view: view,
      interactor: interactor,
      router: router
    )
  }

  override func tearDown() {
    super.tearDown()
    view = nil
    interactor = nil
    router = nil
    presenter = nil
  }

  func testViewDidLoad() {
    XCTAssertFalse(view.invokedSetupUI)
    presenter.viewDidLoad()
    XCTAssertTrue(view.invokedSetupUI)
  }

  func testViewWillAppear() {
    let words = ["Word1", "Word2", "Word3"]
    interactor.mockSavedFavoriteWords = words
    XCTAssertFalse(interactor.invokedFetchSavedFavoriteWords)
    XCTAssertFalse(view.invokedReloadData)
    presenter.viewWillAppear()
    XCTAssertTrue(interactor.invokedFetchSavedFavoriteWords)
    XCTAssertTrue(view.invokedReloadData)
  }

  func testNumberOfItems() {
    let words = ["Word1", "Word2", "Word3"]
    presenter.favoriteWords = words
    let count = presenter.numberOfItems()
    XCTAssertEqual(count, words.count)
  }

  func testCellForRowAt() {
    let words = ["Word1", "Word2", "Word3"]
    presenter.favoriteWords = words
    let indexPath = IndexPath(row: 1, section: 0)
    let word = presenter.cellForRowAt(indexPath: indexPath)
    XCTAssertEqual(word, words[indexPath.row])
  }

  func testDeleteWord() {
    let words = ["Word1", "Word2", "Word3"]
    presenter.favoriteWords = words
    let indexPath = IndexPath(row: 1, section: 0)

    XCTAssertFalse(interactor.invokedDeleteWord)
    XCTAssertFalse(view.invokedReloadData)

    presenter.deleteWord(at: indexPath)

    XCTAssertTrue(interactor.invokedDeleteWord)
    XCTAssertTrue(view.invokedReloadData)
    XCTAssertEqual(presenter.numberOfItems(), words.count - 1)
    XCTAssertFalse(presenter.favoriteWords.contains(words[indexPath.row]))
  }
}
