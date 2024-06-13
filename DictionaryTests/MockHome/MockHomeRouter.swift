//
//  MockRouter.swift
//  DictionaryTests
//
//  Created by alihizardere on 13.06.2024.
//

import Foundation
@testable import Dictionary

final class MockHomeRouter: HomeRouterProtocol {
  var invokedNavigate = false
  var invokedNavigateCount = 0
  var invokedNavigateParameters: (route: HomeRoutes, Void)?

  func navigate(_ route: HomeRoutes) {
    invokedNavigate = true
    invokedNavigateCount += 1
    invokedNavigateParameters = (route, ())
  }
}
