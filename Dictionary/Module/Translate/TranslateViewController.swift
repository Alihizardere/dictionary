//
//  TranslateViewController.swift
//  Dictionary
//
//  Created by alihizardere on 13.06.2024.
//

import UIKit

protocol TranslateViewControllerProtocol: AnyObject {
  func showIndicator()
  func hiddenIndicator()
  func setupUI()
  func configureTranslatedText(text: String?)
  func setupClearButton()
  func setupChangeButton()
}

class TranslateViewController: UIViewController {
  // MARK: - Properties
  @IBOutlet weak var firstCountryLabel: UILabel!
  @IBOutlet weak var secondCountryLabel: UILabel!
  @IBOutlet weak var firstCountryImage: UIImageView!
  @IBOutlet weak var secondCountryImage: UIImageView!
  @IBOutlet weak var inputTextField: UITextField!
  @IBOutlet weak var outputLabel: UILabel!
  @IBOutlet weak var clearButton: UIButton!
  @IBOutlet weak var countryView: UIView!
  @IBOutlet weak var containerView: UIView!
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
  var presenter: TranslatePresenterProtocol!

  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    presenter.viewDidLoad()
  }

  private func translateText() {
    guard let text = inputTextField.text, !text.isEmpty,
          let targetLang = secondCountryLabel.text else { return }
    presenter.translateText(text: text, targetLang: targetLang)
  }

  @IBAction func clearButtonTapped(_ sender: UIButton) {
    presenter.clearButtonTapped()
  }

  @IBAction func changeButtonTapped(_ sender: UIButton) {
    presenter.changeButtonTapped()
  }

  @objc private func dismissKeyboard() {
    translateText()
    view.endEditing(true)
  }
}

// MARK: - TranslateViewControllerProtocols
extension TranslateViewController: TranslateViewControllerProtocol {

  func setupUI() {
    inputTextField.delegate = self
    activityIndicator.isHidden = true
    countryView.addShadow(cornerRadius: 45)
    containerView.addShadow(cornerRadius: 15)
    navigationController?.navigationBar.isHidden = true

    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
    view.addGestureRecognizer(tapGesture)
  }
  
  
  func configureTranslatedText(text: String?) {
    guard let text else { return }
    outputLabel.text = text
  }
  
  func showIndicator() {
    activityIndicator.isHidden = false
    activityIndicator.startAnimating()
  }
  
  func hiddenIndicator() {
    activityIndicator.stopAnimating()
    activityIndicator.isHidden = true
  }

  func setupClearButton() {
    inputTextField.text = ""
    outputLabel.text = ""
    clearButton.isHidden = true
  }

  func setupChangeButton() {
    let tempCountryLabel = firstCountryLabel.text
    firstCountryLabel.text = secondCountryLabel.text
    secondCountryLabel.text = tempCountryLabel

    let tempCountryImage = firstCountryImage.image
    firstCountryImage.image = secondCountryImage.image
    secondCountryImage.image = tempCountryImage

    let tempTextFieldText = inputTextField.text
    inputTextField.text = outputLabel.text
    outputLabel.text = tempTextFieldText
  }

}

// MARK: - UITextFieldDelegates
extension TranslateViewController: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    translateText()
    return true
  }

  func textFieldDidChangeSelection(_ textField: UITextField) {
    clearButton.isHidden = false
  }
}
