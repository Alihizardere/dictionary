//
//  SplashViewController.swift
//  Dictionary
//
//  Created by alihizardere on 6.06.2024.
//

import UIKit

protocol SplashViewControllerProtocol: AnyObject {
  func noInternetConnection()
}

final class SplashViewController: BaseViewController {

  var presenter: SplashPresenterProtocol!

  override func viewDidLoad() {
    super.viewDidLoad()
    presenter.viewDidAppear()
  }
}

extension SplashViewController: SplashViewControllerProtocol {
  func noInternetConnection() {
    showAlert(
      with: "Error",
      message: "No internet connection, please check your connection"
    )
  }
}
