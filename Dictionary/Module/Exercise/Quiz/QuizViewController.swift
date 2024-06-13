//
//  QuizViewController.swift
//  Dictionary
//
//  Created by alihizardere on 11.06.2024.
//

import UIKit

protocol QuizViewControllerProtocol: AnyObject {
  func setupUI()
  func reloadData()
  func setupNextButtonTitle()
  func skipToNextQuestion(index: Int)
}

final class QuizViewController: UIViewController {

  // MARK: - Properties
  @IBOutlet weak var collectionView: UICollectionView!
  @IBOutlet weak var nextButton: UIButton!
  @IBOutlet weak var exitButton: UIButton!
  var presenter: QuizPresenterProtocol!

  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    presenter.viewDidLoad()
  }

  // MARK: - Actions
  @IBAction func nextButtonTapped(_ sender: UIButton) {
    presenter.goToNextQuestion()
  }

  @IBAction func exitButtonTapped(_ sender: UIButton) {
    UIAlertController.showAlert(
      on: self ,
      title: "Exit Quiz",
      message: "Are you sure you want to quit the quiz?",
      primaryButtonTitle: "OK",
      primaryButtonStyle: .destructive,
      primaryButtonHandler: {
        self.presenter.navigateExit()
      },
      secondaryButtonTitle: "Cancel")
  }
}

// MARK: - QuizViewControllerProtocol
extension QuizViewController: QuizViewControllerProtocol {

  func setupUI() {
    navigationController?.navigationBar.isHidden = true
    tabBarController?.tabBar.isHidden = true

    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.register(UINib(nibName: QuestionCell.identifier, bundle: nil), forCellWithReuseIdentifier: QuestionCell.identifier)

    nextButton.layer.cornerRadius = nextButton.frame.height / 3
    exitButton.layer.cornerRadius = exitButton.frame.height / 3
  }

  func reloadData() {
    DispatchQueue.main.async {
      self.collectionView.reloadData()
    }
  }
  
  func setupNextButtonTitle() {
    nextButton.setTitle("Finish", for: .normal)
  }

  func skipToNextQuestion(index: Int) {
    let indexPath = IndexPath(item: index, section: 0)
    collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
  }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension QuizViewController: UICollectionViewDelegate,   UICollectionViewDataSource {

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    presenter.numberOfItems()
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: QuestionCell.identifier, for: indexPath) as! QuestionCell
    if let question = presenter.cellForItem(indexPath: indexPath) {
      cell.configure(questionData: question)
    }
    cell.delegate = self
    return cell
  }
}

// MARK: - QuestionCellDelegate
extension QuizViewController: QuestionCellDelegate {
  func didSelectAnswer(isCorrect: Bool) {
    presenter.answerSelected(isCorrect: isCorrect)
  }
}
