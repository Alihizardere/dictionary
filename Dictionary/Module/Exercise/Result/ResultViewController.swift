//
//  ResultViewController.swift
//  Dictionary
//
//  Created by alihizardere on 11.06.2024.
//

import UIKit

protocol ResultViewControllerProtocol: AnyObject {
  func configureData()
}

final class ResultViewController: UIViewController {

  // MARK: - Properties
  @IBOutlet weak var scoreLabel: UILabel!
  @IBOutlet weak var scoreImage: UIImageView!
  @IBOutlet weak var scoreMessage: UILabel!
  @IBOutlet weak var scoreDescription: UILabel!
  var totalScore: Int?
  var presenter: ResultPresenterProtocol!

  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    if let score = totalScore {
      scoreLabel.text = "\(score)"
      presenter.setScore(score: score)
    }
  }
  @IBAction func playAgainButtonTapped(_ sender: UIButton) {
    presenter.playAgain()
  }
  @IBAction func backToHomeButtonTapped(_ sender: UIButton) {
    presenter.backToHome()
  }
}

// MARK: - ResultViewControllerProtocol
extension ResultViewController: ResultViewControllerProtocol {
  func configureData() {
    scoreImage.image = UIImage(named: "questionMarkIcon")
    scoreDescription.text = "You’re making progress! Try another quiz to continue learning and improving."
    scoreMessage.text = "Good effort!"
  }
}
