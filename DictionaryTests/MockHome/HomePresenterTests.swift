//
//  HomePresenterTests.swift
//  DictionaryTests
//
//  Created by alihizardere on 13.06.2024.
//

import XCTest
@testable import Dictionary

final class HomePresenterTests: XCTestCase {

    var presenter: HomePresenter!
    var view: MockHomeViewController!
    var interactor: MockHomeInteractor!
    var router: MockHomeRouter!

    override func setUp() {
        super.setUp()

        view = MockHomeViewController()
        interactor = MockHomeInteractor()
        router = MockHomeRouter()

        presenter = HomePresenter(
            view: view,
            router: router,
            interactor: interactor
        )
    }

    override func tearDown() {
        view = nil
        interactor = nil
        router = nil
        presenter = nil

        super.tearDown()
    }

    func testViewDidLoadInvokesSetupDelegates() {
        XCTAssertFalse(view.invokedSetupDelegates)
        presenter.viewDidLoad()
        XCTAssertTrue(view.invokedSetupDelegates)
    }

    func testViewWillAppearInvokesFetchSavedWords() {
        XCTAssertFalse(interactor.invokedFetchSavedWords)
        presenter.viewWillAppear()
        XCTAssertTrue(interactor.invokedFetchSavedWords)
    }

    func testWordSearchedInvokesFetchWord() {
        XCTAssertFalse(interactor.invokedFetchWord)
        presenter.wordSearched(word: "home")
        XCTAssertTrue(interactor.invokedFetchWord)
        XCTAssertEqual(interactor.invokedFetchWordParameters?.word, "home")
    }

  func test_fetchNewsOutput() {
    presenter.fetchWordOutput(result: .success(WordResponse.response))
  }

}

extension WordResponse {
  static var response: ([WordResponse]) {
    let bundle = Bundle(for: HomePresenterTests.self)
    let path = bundle.path(forResource: "WordResponse", ofType: "json")!
    let file = try! String(contentsOfFile: path)
    let data = file.data(using: .utf8)!
    let response = try! JSONDecoder().decode([WordResponse].self, from: data)
    return response
  }
}
