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
  func setupTableView()
  func reloadData()
  func configureData(result: [WordResponse])
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
  @IBOutlet weak var tableView: UITableView!
  var presenter: DetailPresenterProtocol!
  var selectedWord: [WordResponse]? {
    didSet {
      if let word = selectedWord {
        presenter.setWordResults(result: word)
      }
    }
  }

  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    presenter.viewDidLoad()
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
    cancelButton.isHidden = true
    selectedSectionButton.isHidden = true
  }

  private func toggleSection(section: String, button: UIButton) {
    presenter.toggleSection(section: section)
  }
}

// MARK: - DetailViewControllerProtocol
extension DetailViewController: DetailViewControllerProtocol {

  func setupTableView() {
    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(UINib(nibName: WordTypeCell.identifier, bundle: nil), forCellReuseIdentifier: WordTypeCell.identifier)
    tableView.register(UINib(nibName: SynonymCell.identifier, bundle: nil), forCellReuseIdentifier: SynonymCell.identifier)
  }
  
  func reloadData() {
    DispatchQueue.main.async {
      self.tableView.reloadData()
    }
  }

  func configureData(result: [WordResponse]) {
    titleLabel.text = result.first?.word
    secondaryTitle.text = result.first?.phonetic
  }

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

// MARK: - SynonymCellDelegate
extension DetailViewController: SynonymCellDelegate {
  func synonymButtonTapped(_ synonym: String) {
    presenter.fetchSynonymDetail(word: synonym)
  }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension DetailViewController: UITableViewDelegate, UITableViewDataSource {

  func numberOfSections(in tableView: UITableView) -> Int {
    presenter.numberOfSections()
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    presenter.numberOfRowsInSection(section: section)
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

    if indexPath.section == presenter.numberOfSections() - 1 {
      let cell = tableView.dequeueReusableCell(withIdentifier: SynonymCell.identifier , for: indexPath) as! SynonymCell
      let synonyms = presenter.getSynonyms()
      cell.delegate = self
      cell.setupSynonymCell(synonyms: synonyms)
      return cell
    } else {
      let cell = tableView.dequeueReusableCell(withIdentifier: WordTypeCell.identifier, for: indexPath) as! WordTypeCell
      if let data = presenter.wordTypeData(indexPath: indexPath) {
        cell.configure(sectionKey: data.sectionKey, definition: data.definition)
      }
      return cell
    }
  }
}
