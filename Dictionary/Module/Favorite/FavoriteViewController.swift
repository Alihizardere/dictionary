//
//  FavoriteViewController.swift
//  Dictionary
//
//  Created by alihizardere on 13.06.2024.
//

import UIKit

protocol FavoriteViewControllerProtocol: AnyObject {
  func setupUI()
  func reloadData()
}

final class FavoriteViewController: UIViewController {

  // MARK: - Properties
  @IBOutlet weak var tableView: UITableView!
  var presenter: FavoritePresenterProtocol!

  // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
      presenter.viewDidLoad()
    }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    presenter.viewWillAppear()
  }
}

// MARK: - FavoriteViewControllerProtocol
extension FavoriteViewController: FavoriteViewControllerProtocol {

  func setupUI() {
    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(UINib(nibName: FavoriteWordCell.identifier, bundle: nil), forCellReuseIdentifier: FavoriteWordCell.identifier)
  }

  func reloadData() {
    DispatchQueue.main.async {
      if self.presenter.numberOfItems() == 0 {
        self.tableView.setEmptyView(
          "Your favorite list is empty",
          message: "Add words to your favorites to access them here."
        )
      } else {
        self.tableView.restore()
      }
      self.tableView.reloadData()
    }
  }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension FavoriteViewController: UITableViewDelegate, UITableViewDataSource {

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    presenter.numberOfItems()
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteWordCell.identifier, for: indexPath) as! FavoriteWordCell
    cell.delegate = self
    cell.indexPath = indexPath
    if let word = presenter.cellForRowAt(indexPath: indexPath) {
      cell.wordLabel.text = word
    }
    return cell
  }
}

// MARK: - FavoriteWordCellDelegate
extension FavoriteViewController: FavoriteWordCellDelegate {
  func deleteButtonTapped(at indexPath: IndexPath) {
    UIAlertController.showAlert(
      on: self ,
      title: "Delete Word",
      message: "Are you sure you want to delete the word?",
      primaryButtonTitle: "OK",
      primaryButtonStyle: .destructive,
      primaryButtonHandler: {
        self.presenter.deleteWord(at: indexPath)
      },
      secondaryButtonTitle: "Cancel")
  }
}
