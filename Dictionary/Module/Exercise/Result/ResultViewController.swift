//
//  ResultViewController.swift
//  Dictionary
//
//  Created by alihizardere on 11.06.2024.
//

import UIKit

protocol ResultViewControllerProtocol: AnyObject {
  func setupUI()
  func configureData()
}

final class ResultViewController: UIViewController {

  // MARK: - Properties
  @IBOutlet weak var scoreLabel: UILabel!
  @IBOutlet weak var scoreImage: UIImageView!
  @IBOutlet weak var scoreMessage: UILabel!
  @IBOutlet weak var scoreDescription: UILabel!
  @IBOutlet weak var playButton: UIButton!
  @IBOutlet weak var backToHomeButton: UIButton!
  var totalScore: Int?
  var presenter: ResultPresenterProtocol!

  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    presenter.viewDidload()
    if let score = totalScore {
      scoreLabel.text = "\(score)"
      presenter.setScore(score: score)
    }
  }
  // MARK: - Actions
  @IBAction func playAgainButtonTapped(_ sender: UIButton) {
    presenter.playAgain()
  }
  @IBAction func backToHomeButtonTapped(_ sender: UIButton) {
    presenter.backToHome()
  }
}

// MARK: - ResultViewControllerProtocol
extension ResultViewController: ResultViewControllerProtocol {

  func setupUI(){
    playButton.layer.cornerRadius = 8
    backToHomeButton.layer.cornerRadius = 8
  }

  func configureData() {
    scoreImage.image = UIImage(named: "effort")
    scoreDescription.text = "You’re making progress! Try another quiz to continue learning and improving."
    scoreMessage.text = "Good effort!"
  }
}
