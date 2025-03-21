//
//  HomeViewController.swift
//  Dictionary
//
//  Created by alihizardere on 6.06.2024.
//

import UIKit

protocol HomeViewControllerProtocol: AnyObject {
  func setupUI()
  func setupDelegates()
  func reloadData()
  func showErrorAlert()
  func setSearchBarText()
}

final class HomeViewController: UIViewController {

  // MARK: - Properties
  @IBOutlet weak var searchBar: UISearchBar!
  @IBOutlet weak var searchButton: UIButton!
  @IBOutlet weak var tableView: UITableView!
  var presenter: HomePresenterProtocol!

  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    presenter.viewDidLoad()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    presenter.viewWillAppear()
    navigationController?.navigationBar.isHidden = true
  }

  // MARK: - Acitons && Functions
  @IBAction func searchButtonTapped(_ sender: Any) {
    guard let word = searchBar.text, !word.isEmpty else { return }
    presenter.wordSearched(word: word)
  }

  @objc private func dismissKeyboard() {
    view.endEditing(true)
  }

  private func searchButtonForKeyboard(show: Bool) {
    let translationY: CGFloat = show ? -view.frame.height / 3.20 : 0
    UIView.animate(withDuration: 0.3) {
      self.searchButton.transform = CGAffineTransform(translationX: 0, y: translationY)
    }
  }
}


// MARK: - HomeViewControllerProtocol
extension HomeViewController: HomeViewControllerProtocol {

  func setupUI() {
    searchButton.layer.cornerRadius = searchButton.frame.height / 2
  }
  
  func setupDelegates() {
    searchBar.delegate = self
    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(
      UINib(nibName: RecentSearchCell.identifier, bundle: nil),
      forCellReuseIdentifier: RecentSearchCell.identifier
    )
  }

  func reloadData() {
    DispatchQueue.main.async {
      if self.presenter.numberOfItems() == 0 {
        self.tableView.setEmptyView(
          "No Recent Searches",
          message: "You have not searched for any words recently"
        )
      } else {
        self.tableView.restore()
      }
      self.tableView.reloadData()
    }
  }

  func setSearchBarText() {
    searchBar.text = ""
    dismissKeyboard()
  }

  func showErrorAlert() {
    UIAlertController.showAlert(
      on: self ,
      title: "Word Not Found",
      message: "Sorry, the word you are looking for could not be found. Please try another word.",
      primaryButtonTitle: "OK",
      primaryButtonStyle: .destructive)
  }
}

// MARK: -  UITableViewDelegate, UITableViewDataSource
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    presenter.numberOfItems()
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(
      withIdentifier: RecentSearchCell.identifier,
      for: indexPath
    ) as! RecentSearchCell
    if let word = presenter.word(indexPath: indexPath) {
      cell.recentSearchLabel.text = word
    }
    return cell
  }
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    presenter.didSelectRowAt(indexPath)
    dismissKeyboard()
  }

  func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    let deleteAction = UIContextualAction(style: .destructive, title: "") { _, _, _ in
      self.presenter.deleteWord(at: indexPath)
    }
    deleteAction.image = UIImage(systemName: "trash.fill")
    return UISwipeActionsConfiguration(actions: [deleteAction])
  }
}

// MARK: - UISearchBarDelegates
extension HomeViewController: UISearchBarDelegate {

  func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
    searchButtonForKeyboard(show: true)
  }

  func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
    searchButtonForKeyboard(show: false)
  }

  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    guard let word = searchBar.text, !word.isEmpty else { return }
    presenter.wordSearched(word: word)
  }
}
