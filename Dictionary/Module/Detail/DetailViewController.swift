//
//  DetailViewController.swift
//  Dictionary
//
//  Created by alihizardere on 7.06.2024.
//

import UIKit

protocol DetailViewControllerProtocol: AnyObject {

}

final class DetailViewController: UIViewController {

  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var secondaryTitle: UILabel!
  
  var presenter: DetailPresenterProtocol!
  var selectedWord: [WordResponse]?
  override func viewDidLoad() {
    super.viewDidLoad()
    if let word = selectedWord {
      titleLabel.text = word.first?.word
      secondaryTitle.text = word.first?.phonetic
    }
  }
}

extension DetailViewController: DetailViewControllerProtocol {

}
