//
//  HomeViewController.swift
//  Dictionary
//
//  Created by alihizardere on 6.06.2024.
//

import UIKit

protocol HomeViewControllerProtocol: AnyObject {

}

final class HomeViewController: UIViewController {

  @IBOutlet weak var searchBar: UISearchBar!
  @IBOutlet weak var searchButton: UIButton!
  var presenter: HomePresenterProtocol!

  override func viewDidLoad() {
    super.viewDidLoad()
    searchBar.delegate = self

    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
    view.addGestureRecognizer(tapGesture)
  }

  @IBAction func searchButtonTapped(_ sender: Any) {
    guard let word = searchBar.text, !word.isEmpty else { return }
    presenter.didSelectWord(word: word)
  }

  @objc func dismissKeyboard() {
    view.endEditing(true)
  }

  private func searchButtonForKeyboard(show: Bool) {
    let translationY: CGFloat = show ? -view.frame.height / 2.85 : 0
    UIView.animate(withDuration: 0.3) {
      self.searchButton.transform = CGAffineTransform(translationX: 0, y: translationY)
    }
  }
}


extension HomeViewController: HomeViewControllerProtocol {

}

extension HomeViewController: UISearchBarDelegate {

  func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
    searchButtonForKeyboard(show: true)
  }

  func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
    searchButtonForKeyboard(show: false)
  }
}
