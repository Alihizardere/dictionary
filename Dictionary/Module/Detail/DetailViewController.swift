//
//  DetailViewController.swift
//  Dictionary
//
//  Created by alihizardere on 7.06.2024.
//

import UIKit

protocol DetailViewControllerProtocol: AnyObject {
  func setSectionButtonTitle(title:String?)
  func setupSectionButtonDisplay()
  func hideButton(for section: String)
  func showButton(for section: String)
  func resetButtonVisibility()
}

final class DetailViewController: UIViewController {

  // MARK: - Properties
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var secondaryTitle: UILabel!
  @IBOutlet weak var selectedSectionButton: UIButton!
  @IBOutlet weak var nounButton: UIButton!
  @IBOutlet weak var verbButton: UIButton!
  @IBOutlet weak var adjectiveButton: UIButton!
  @IBOutlet weak var cancelButton: UIButton!
  var presenter: DetailPresenterProtocol!
  var selectedWord: [WordResponse]?

  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    if let word = selectedWord {
      titleLabel.text = word.first?.word
      secondaryTitle.text = word.first?.phonetic
    }
  }
  
// MARK: - Actions && Functions
  @IBAction func nounButtonTapped(_ sender: UIButton) {
    presenter.toggleSection(section: "Noun")
  }
  
  @IBAction func verbButtonTapped(_ sender: UIButton) {
    presenter.toggleSection(section: "Verb")
  }

  @IBAction func adjectiveButtonTapped(_ sender: UIButton) {
    presenter.toggleSection(section: "Adjective")
  }

  @IBAction func cancelButtonTapped(_ sender: Any) {
    presenter.cancelButtonTapped()
    selectedSectionButton.isHidden = true
    // TODO - tableview reload
  }

  private func toggleSection(section: String, button: UIButton) {
    presenter.toggleSection(section: section)
    // TODO - tableview reload
  }
}

// MARK: - DetailViewControllerProtocol
extension DetailViewController: DetailViewControllerProtocol {
  
  func setupSectionButtonDisplay() {
    cancelButton.isHidden = false
    selectedSectionButton.layer.borderWidth = 2
    selectedSectionButton.layer.cornerRadius = selectedSectionButton.frame.height / 2
    selectedSectionButton.layer.borderColor = UIColor.orange.cgColor
  }

  func setSectionButtonTitle(title:String?) {
    selectedSectionButton.setTitle(title, for: .normal)
    selectedSectionButton.isHidden = false
  }

  func resetButtonVisibility() {
    nounButton.isHidden = false
    verbButton.isHidden = false
    adjectiveButton.isHidden = false
  }

  func hideButton(for section: String) {
    switch section {
    case "Noun":
      nounButton.isHidden = true
    case "Verb":
      verbButton.isHidden = true
    case "Adjective":
      adjectiveButton.isHidden = true
    default:
      break
    }
  }

  func showButton(for section: String) {
    switch section {
    case "Noun":
      nounButton.isHidden = false
    case "Verb":
      verbButton.isHidden = false
    case "Adjective":
      adjectiveButton.isHidden = false
    default:
      break
    }
  }
}
