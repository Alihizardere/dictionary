//
//  DetailViewController.swift
//  Dictionary
//
//  Created by alihizardere on 7.06.2024.
//

import UIKit

protocol DetailViewControllerProtocol: AnyObject {
  func setSectionButtonTitle(title:String?)
  func setupSectionButtonShow()
  func hideButton(for section: String)
  func showButton(for section: String)
  func resetButtonVisibility()
  func setupUI()
  func reloadData()
  func configureData(result: [WordResponse])
  func setAudioButton(hasAudio: Bool)
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
  @IBOutlet weak var favoriteButton: UIButton!
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var audioButton: UIButton!
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

  @IBAction func cancelButtonTapped(_ sender: UIButton) {
    presenter.cancelButtonTapped()
    cancelButton.isHidden = true
    selectedSectionButton.isHidden = true
  }
  @IBAction func favoriteButtonTapped(_ sender: UIButton) {
    presenter.favoriteButton()
  }
  
  @IBAction func audioButtonTapped(_ sender: Any) {
    if let word = selectedWord {
      presenter.playAudio(word: word)
    }
  }

  @IBAction func backButtonTapped(_ sender: Any) {
    navigationController?.popViewController(animated: true)
  }
  
  private func toggleSection(section: String) {
    presenter.toggleSection(section: section)
  }

  private func setupButton(_ button: UIButton) {
    button.layer.borderWidth = 2
    button.layer.borderColor = UIColor.lightGray.cgColor
    button.layer.cornerRadius = button.frame.height / 2
  }
}

// MARK: - DetailViewControllerProtocols
extension DetailViewController: DetailViewControllerProtocol {

  func setupUI() {
    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(
      UINib(nibName: WordTypeCell.identifier, bundle: nil),
      forCellReuseIdentifier: WordTypeCell.identifier
    )
    tableView.register(
      UINib(nibName: SynonymCell.identifier, bundle: nil),
      forCellReuseIdentifier: SynonymCell.identifier
    )

    setupButton(nounButton)
    setupButton(verbButton)
    setupButton(adjectiveButton)
    setupButton(cancelButton)
    cancelButton.layer.borderColor = UIColor.button.cgColor
  }
  
  func reloadData() {
    DispatchQueue.main.async {
      self.tableView.reloadData()
    }
  }

  func configureData(result: [WordResponse]) {
    titleLabel.text = result.first?.word?.capitalized
    secondaryTitle.text = result.first?.phonetic
    selectedWord = result
    presenter.updateAudioButtonVisibility()
  }

  func setupSectionButtonShow() {
    cancelButton.isHidden = false
    selectedSectionButton.layer.borderWidth = 2
    selectedSectionButton.layer.cornerRadius = selectedSectionButton.frame.height / 2
    selectedSectionButton.layer.borderColor = UIColor.button.cgColor
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

  func setAudioButton(hasAudio: Bool){
    audioButton.isHidden = !hasAudio
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
      cell.delegate = self
      let synonyms = presenter.getSynonyms()
      cell.setupSynonymCell(synonyms: synonyms)
      return cell
    } else {
      let cell = tableView.dequeueReusableCell(withIdentifier: WordTypeCell.identifier, for: indexPath) as! WordTypeCell
      if let data = presenter.wordTypeData(indexPath: indexPath) {
        cell.configure(sectionKey: data.sectionKey, definition: data.definition, indexPath: indexPath.row)
      }
      return cell
    }
  }
}

// MARK: - SynonymCellDelegate
extension DetailViewController: SynonymCellDelegate {
  func synonymButtonTapped(_ synonym: String) {
    presenter.fetchSynonymDetail(word: synonym)
  }
}
