//
//  HomeViewController.swift
//  Dictionary
//
//  Created by alihizardere on 6.06.2024.
//

import UIKit

protocol HomeViewControllerProtocol: AnyObject {

}
fileprivate var wordService: WordServiceProtocol = API()
typealias WordSourceResult = Result<WordResponse, NetworkError>

final class HomeViewController: UIViewController {

  var presenter: HomePresenterProtocol!
  
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension HomeViewController: HomeViewControllerProtocol {

}
