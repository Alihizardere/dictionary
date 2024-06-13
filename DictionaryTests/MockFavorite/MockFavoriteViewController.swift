//
//  MockFavoriteViewController.swift
//  DictionaryTests
//
//  Created by alihizardere on 13.06.2024.
//

import Foundation
@testable import Dictionary

class MockFavoriteViewController: FavoriteViewControllerProtocol {

  var invokedSetupUI = false
  var invokedReloadData = false

  func setupUI() {
    invokedSetupUI = true
  }

  func reloadData() {
    invokedReloadData = true
  }
}
