//
//  MockHomeViewController.swift
//  DictionaryTests
//
//  Created by alihizardere on 13.06.2024.
//

import Foundation
@testable import Dictionary

var invokedSetupUI = false
var invokedSetupUICount = 0

var invokedSetupDelegates = false
var invokedSetupDelegatesCount = 0

var invokedReloadData = false
var invokedReloadDataCount = 0


final class MockHomeViewController: HomeViewControllerProtocol {
  
  func setupUI() {
    invokedSetupUI = true
    invokedSetupUICount += 1
  }
  
  func setupDelegates() {
    invokedSetupDelegates = true
    invokedSetupDelegatesCount += 1
  }
  
  func reloadData() {
    invokedReloadData = true
    invokedReloadDataCount += 1
  }
}
