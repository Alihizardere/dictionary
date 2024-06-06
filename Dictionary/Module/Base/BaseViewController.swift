//
//  BaseViewController.swift
//  Dictionary
//
//  Created by alihizardere on 6.06.2024.
//

import UIKit

class BaseViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
  }

  func showAlert(with title: String, message: String) {
      let alert = UIAlertController(
          title: title,
          message: message,
          preferredStyle: .alert
      )
      alert.addAction(UIAlertAction(title: "OK", style: .default))
      present(alert, animated: true)
  }
}
