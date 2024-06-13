//
//  TranslateViewController.swift
//  Dictionary
//
//  Created by alihizardere on 13.06.2024.
//

import UIKit

protocol TranslateViewControllerProtocol: AnyObject {

}

class TranslateViewController: UIViewController {

  var presenter: TranslatePresenterProtocol!
  
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension TranslateViewController: TranslateViewControllerProtocol {

}
