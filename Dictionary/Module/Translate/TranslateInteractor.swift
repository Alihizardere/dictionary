//
//  TranslateInteractor.swift
//  Dictionary
//
//  Created by alihizardere on 13.06.2024.
//

import Foundation

fileprivate var wordService: WordServiceProtocol = API()
typealias translateSourceResult = Result<TranslateResponse, NetworkError>

protocol TranslateInteractorProtocol {
  func translateText(text: String?, targetLang: String?)
}

protocol TranslateInteractorOutputProtocol {
  func translateTextOutput(result: translateSourceResult)
}

final class TranslateInteractor {
  var output: TranslateInteractorOutputProtocol?
}

extension TranslateInteractor: TranslateInteractorProtocol {
  func translateText(text: String?, targetLang: String?) {
    guard let text, let targetLang else { return }
    wordService.translateText(text: text, targetLang: targetLang) { [weak self] result in
      DispatchQueue.main.async {
        self?.output?.translateTextOutput(result: result)
      }
    }
  }
}

