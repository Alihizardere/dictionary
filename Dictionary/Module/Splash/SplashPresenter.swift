//
//  SplashPresenter.swift
//  Dictionary
//
//  Created by alihizardere on 6.06.2024.
//

import Foundation

protocol SplashPresenterProtocol {
  func viewDidAppear()
}

final class SplashPresenter: SplashPresenterProtocol {
  
  // MARK: - Properties
  unowned var view: SplashViewControllerProtocol!
  let router: SplashRouterProtocol!
  let interactor: SplashInteractorProtocol!

  init(
    view: SplashViewControllerProtocol,
    router: SplashRouterProtocol,
    interactor: SplashInteractorProtocol
  ) {
    self.view = view
    self.router = router
    self.interactor = interactor
  }

  func viewDidAppear() {
    interactor.checkInternetConnection()
  }
}

// MARK: - SplashInteractorOutputProtocol
extension SplashPresenter: SplashInteractorOutputProtocol {

  func internetConnection(status: Bool) {
    if status {
      DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
        self.router.navigate(.home)
      }
    } else {
      DispatchQueue.main.async {
        self.view.noInternetConnection()
      }
    }
  }
}
