//
//  DetailPresenter.swift
//  Dictionary
//
//  Created by alihizardere on 8.06.2024.
//

import Foundation
import AVFoundation

protocol DetailPresenterProtocol {
  func viewDidLoad()
  func toggleSection(section: String)
  func updateSelectedSectionButton(section: String)
  func cancelButtonTapped()
  func setWordResults(result: [WordResponse])
  func numberOfSections() -> Int
  func numberOfRowsInSection(section: Int) -> Int
  func wordTypeData(indexPath: IndexPath) -> (sectionKey: String, definition: Definition)?
  func getSynonyms() -> [Synonym]
  func fetchSynonymDetail(word: String)
  func playAudio(word: [WordResponse])
  func updateAudioButtonVisibility()
  func favoriteButton()
}

final class DetailPresenter {

  // MARK: - Properties
  weak var view: DetailViewControllerProtocol!
  let interactor: DetailInteractorProtocol
  let router: DetailRouterProtocol
  private var wordResults = [WordResponse]()
  private var sections = ["Noun", "Verb", "Adjective"]
  private var synonyms = [Synonym]()
  private var player: AVPlayer?

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

// MARK: - DetailPresenterProtocols
extension DetailPresenter: DetailPresenterProtocol {

  func viewDidLoad() {
    if let word = wordResults.first?.word {
      fetchSynonymWords(word: word)
    }
    view.configureData(result: wordResults)
    view.setupUI()
    updateAudioButtonVisibility() 
  }

  func fetchSynonymDetail(word: String){
    fetchSynonymWords(word: word)
    fetchSynonym(word: word)
  }

  func wordTypeData(indexPath: IndexPath) -> (sectionKey: String, definition: Definition)? {
    let sectionKey = sections[indexPath.section]
    let meanings = wordResults.flatMap { $0.meanings ?? [] }.filter { $0.partOfSpeech?.lowercased() == sectionKey.lowercased() }
    let definitions = meanings.flatMap { $0.definitions }
    let definiton = definitions[indexPath.row]
    return (sectionKey, definiton)
  }

  func numberOfSections() -> Int {
    sections.count + 1
  }
  
  func numberOfRowsInSection(section: Int) -> Int {
    if section == sections.count {
      return 1
    }
    let sectionKey = sections[section]
    let meanings = wordResults.flatMap { $0.meanings ?? [] }.filter { $0.partOfSpeech?.lowercased() == sectionKey.lowercased() }
    return meanings.flatMap { $0.definitions }.count
  }
  
  func setWordResults(result: [WordResponse]) {
      wordResults = result
  }

  func getSynonyms() -> [Synonym] {
    return synonyms
  }

  func toggleSection(section: String) {
    if sections.contains(section) {
      sections.removeAll(where: { $0 != section })
    } else {
      sections.append(section)
    }
    view.setupSectionButtonShow()
    view.reloadData()
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
    view.reloadData()
    view.resetButtonVisibility()
  }

  func favoriteButton() {
    if let word = wordResults.first?.word {
      interactor.saveFavoriteWord(word: word)
    }
  }

  func playAudio(word: [WordResponse]) {
    for response in word {
      if let phonetics = response.phonetics {
        for phonetic in phonetics {
          if let audio = phonetic.audio, let url = URL(string: audio) {
            player = AVPlayer(url: url)
            player?.play()
            return
          }
        }
      }
    }
  }

  func updateAudioButtonVisibility() {
    var audioAvailable = false
    for response in wordResults {
      if let phonetics = response.phonetics {
        for phonetic in phonetics {
          if let _ = phonetic.audio {
            audioAvailable = true
            break
          }
        }
      }
    }
    view.setAudioButton(hasAudio: audioAvailable)
  }

  private func fetchSynonymWords(word: String) {
    interactor.fetchSynonymWords(word: word)
  }

  private func fetchSynonym(word: String){
    interactor.fetchSynonymDetail(for: word)
  }
}

// MARK: - DetailInteractorOutputProtocol
extension DetailPresenter: DetailInteractorOutputProtocol {

  func fetchSynonymWordsOutput(result: SynonymWordResult) {
    switch result {
    case .success(let synonymWord):
      DispatchQueue.main.async {
        self.synonyms = synonymWord
        self.view.reloadData()
      }
    case .failure(let error):
      print(error.localizedDescription)
    }
  }

  func fetchSynonymDetailOutput(result: WordResult) {
    switch result {
    case .success(let word):
      view.configureData(result: word)
      view.reloadData()
    case .failure(let error):
      print(error.localizedDescription)
    }
  }
}
