//
//  EntryViewController.swift
//  Dictionary
//
//  Created by alihizardere on 11.06.2024.
//

import UIKit

final class EntryViewController: UIViewController {

  var presenter: EntryPresenterProtocol!
  
    override func viewDidLoad() {
        super.viewDidLoad()
    }

  @IBAction func playButtonTapped(_ sender: UIButton) {
    presenter.navigateQuiz()
  }
}

