//
//  TranslatePresenter.swift
//  Dictionary
//
//  Created by alihizardere on 13.06.2024.
//

import Foundation

protocol TranslatePresenterProtocol {
  func viewDidLoad()
  func translateText(text: String?, targetLang: String?)
  func clearButtonTapped()
  func changeButtonTapped()
}

final class TranslatePresenter {

  weak var view: TranslateViewControllerProtocol!
  let interactor: TranslateInteractorProtocol
  let router: TranslateRouter

  init(
    view: TranslateViewControllerProtocol!,
    interactor: TranslateInteractorProtocol,
    router: TranslateRouter
  ) {
    self.view = view
    self.interactor = interactor
    self.router = router
  }  
}

extension TranslatePresenter: TranslatePresenterProtocol {
  func viewDidLoad() {
    view.setupUI()
  }
  
  func translateText(text: String?, targetLang: String?) {
    interactor.translateText(text: text, targetLang: targetLang)
    view.showIndicator()
  }

  func clearButtonTapped() {
    view.setupClearButton()
  }

  func changeButtonTapped() {
    view.setupChangeButton()
  }

}

extension TranslatePresenter: TranslateInteractorOutputProtocol {
  func translateTextOutput(result: translateSourceResult) {
    switch result {
    case .success(let translateResponse):
      DispatchQueue.main.async {
        self.view.hiddenIndicator()
         let text = translateResponse.translations.first?.text ?? "Çeviri bulunamadı"
        self.view.configureTranslatedText(text: text)
      }
    case .failure(let error):
      print(error.localizedDescription)
    }
  }
}
