//
//  EntryViewController.swift
//  Dictionary
//
//  Created by alihizardere on 11.06.2024.
//

import UIKit

final class EntryViewController: UIViewController {

  @IBOutlet weak var playButton: UIButton!
  @IBOutlet weak var topicButton: UIButton!
  var presenter: EntryPresenterProtocol!

  override func viewDidLoad() {
    super.viewDidLoad()
    playButton.layer.cornerRadius = playButton.frame.height / 2
    topicButton.layer.cornerRadius = topicButton.frame.height / 2
  }

  @IBAction func playButtonTapped(_ sender: UIButton) {
    presenter.navigateQuiz()
  }
}

