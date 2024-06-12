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

  static let identifier = "QuestionCell"
  @IBOutlet weak var questionLabel: UILabel!
  @IBOutlet weak var optionAButton: UIButton!
  @IBOutlet weak var optionBButton: UIButton!
  @IBOutlet weak var optionCButton: UIButton!
  @IBOutlet weak var optionDButton: UIButton!
  weak var delegate: QuestionCellDelegate?
  private var correctAnswer = ""
  private var isOptionSelected = false

  override func awakeFromNib() {
    super.awakeFromNib()
    setupUI()
  }
  private func setupUI(){
    questionLabel.layer.cornerRadius = questionLabel.frame.height / 7
    questionLabel.layer.borderWidth = 2
    questionLabel.layer.borderColor = UIColor.button.cgColor

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
    button.layer.borderColor = UIColor.lightGray.cgColor
    button.addTarget(self, action: #selector(optionButtonTapped), for: .touchUpInside)
  }

  private func resetButtonStates() {
    optionAButton.backgroundColor = .clear
    optionBButton.backgroundColor = .clear
    optionCButton.backgroundColor = .clear
    optionDButton.backgroundColor = .clear
  }

  @objc func optionButtonTapped(_ sender: UIButton) {
    guard !isOptionSelected else { return }
    isOptionSelected = true

    let selectedOption = sender.title(for: .normal)
    let isCorrect = (selectedOption == correctAnswer)

    if isCorrect {
      sender.backgroundColor = .green
    } else {
      sender.backgroundColor = .red
      highlightCorrectAnswer()
    }
    delegate?.didSelectAnswer(isCorrect: isCorrect)
  }

  private func highlightCorrectAnswer() {
    if optionAButton.title(for: .normal) == correctAnswer {
      optionAButton.backgroundColor = .green
    } else if optionBButton.title(for: .normal) == correctAnswer {
      optionBButton.backgroundColor = .green
    } else if optionCButton.title(for: .normal) == correctAnswer {
      optionCButton.backgroundColor = .green
    } else if optionDButton.title(for: .normal) == correctAnswer {
      optionDButton.backgroundColor = .green
    }
  }
}
