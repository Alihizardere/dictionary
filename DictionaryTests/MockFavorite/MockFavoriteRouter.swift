//
//  MockFavoriteRouter.swift
//  DictionaryTests
//
//  Created by alihizardere on 13.06.2024.
//

import Foundation

import Foundation
@testable import Dictionary

class MockFavoriteRouter: FavoriteRouterProtocol {
  
  var viewController: FavoriteViewController?
  var invokedNavigateToDetail = false
  
  func navigateToDetail() {
    invokedNavigateToDetail = true
    
  }
}
