//
//  DetailPresenter.swift
//  Dictionary
//
//  Created by alihizardere on 8.06.2024.
//

import Foundation

protocol DetailPresenterProtocol {
  func toggleSection(section: String)
  func updateSelectedSectionButton(section: String)
  func cancelButtonTapped()
}

final class DetailPresenter {

  weak var view: DetailViewControllerProtocol!
  let interactor: DetailInteractorProtocol
  let router: DetailRouterProtocol
  private var sections = ["Noun", "Verb", "Adjective"]

  init(
    view: DetailViewControllerProtocol!,
    interactor: DetailInteractorProtocol,
    router: DetailRouterProtocol
  ) {
    self.view = view
    self.interactor = interactor
    self.router = router
  }
}

extension DetailPresenter: DetailPresenterProtocol {

  func toggleSection(section: String) {
    if sections.contains(section) {
      sections.removeAll(where: { $0 != section })
    } else {
      sections.append(section)
    }
    view.setupSectionButtonDisplay()
    updateSelectedSectionButton(section: section)
  }

  func updateSelectedSectionButton(section: String) {
    let updatedTitle = sections.joined(separator: ", ")
    view.setSectionButtonTitle(title: updatedTitle)
    if sections.contains(section) {
      view.hideButton(for: section)
    } else {
      view.showButton(for: section)
    }
  }

  func cancelButtonTapped() {
    sections = ["Noun", "Verb", "Adjective"]
    view.resetButtonVisibility()
  }
}

extension DetailPresenter: DetailInteractorOutputProtocol {

}
