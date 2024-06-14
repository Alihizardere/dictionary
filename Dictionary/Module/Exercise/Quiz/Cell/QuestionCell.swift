//
//  QuestionCell.swift
//  Dictionary
//
//  Created by alihizardere on 11.06.2024.
//

import UIKit

protocol QuestionCellDelegate: AnyObject {
  func didSelectAnswer(isCorrect: Bool)
}

class QuestionCell: UICollectionViewCell {

  // MARK: - Properties
  static let identifier = "QuestionCell"
  @IBOutlet weak var questionLabel: UILabel!
  @IBOutlet weak var optionAButton: UIButton!
  @IBOutlet weak var optionBButton: UIButton!
  @IBOutlet weak var optionCButton: UIButton!
  @IBOutlet weak var optionDButton: UIButton!
  @IBOutlet weak var cardView: UIView!
  weak var delegate: QuestionCellDelegate?
  private var correctAnswer = ""
  private var isOptionSelected = false

  override func awakeFromNib() {
    super.awakeFromNib()
    setupUI()
  }

  // MARK: - Functions && Actions
  private func setupUI(){
    cardView.layer.cornerRadius = questionLabel.frame.height / 7
    cardView.layer.borderWidth = 2
    cardView.layer.borderColor = UIColor.main.cgColor

    setupButton(optionAButton)
    setupButton(optionBButton)
    setupButton(optionCButton)
    setupButton(optionDButton)
  }

  func configure(questionData: QuizQuestion) {
    resetButtonStates()

    questionLabel.text = questionData.question
    optionAButton.setTitle(questionData.optionA, for: .normal)
    optionBButton.setTitle(questionData.optionB, for: .normal)
    optionCButton.setTitle(questionData.optionC, for: .normal)
    optionDButton.setTitle(questionData.optionD, for: .normal)

    correctAnswer = questionData.correctAnswer
    isOptionSelected = false
  }

  private func setupButton(_ button: UIButton) {
    button.layer.cornerRadius = button.frame.height / 2
    button.layer.borderWidth = 2
    button.layer.borderColor = UIColor.main.cgColor
    button.addTarget(self, action: #selector(optionButtonTapped), for: .touchUpInside)
  }

  private func resetButtonStates() {
    optionAButton.backgroundColor = .clear
    optionBButton.backgroundColor = .clear
    optionCButton.backgroundColor = .clear
    optionDButton.backgroundColor = .clear
  }

  private func highlightCorrectAnswer() {
    if optionAButton.title(for: .normal) == correctAnswer {
      optionAButton.backgroundColor = .button
    } else if optionBButton.title(for: .normal) == correctAnswer {
      optionBButton.backgroundColor = .button
    } else if optionCButton.title(for: .normal) == correctAnswer {
      optionCButton.backgroundColor = .button
    } else if optionDButton.title(for: .normal) == correctAnswer {
      optionDButton.backgroundColor = .button
    }
  }

  @objc func optionButtonTapped(_ sender: UIButton) {
    guard !isOptionSelected else { return }
    isOptionSelected = true

    let selectedOption = sender.title(for: .normal)
    let isCorrect = (selectedOption == correctAnswer)

    if isCorrect {
      sender.backgroundColor = .button
    } else {
      sender.backgroundColor = .systemGray3
      highlightCorrectAnswer()
    }
    delegate?.didSelectAnswer(isCorrect: isCorrect)
  }
}
