//
//  ServiceManager.swift
//  Dictionary
//
//  Created by alihizardere on 6.06.2024.
//

import Foundation

protocol WordServiceProtocol {
  func fetchWord(word: String, completion: @escaping (Result<[WordResponse], NetworkError>) -> Void)
  func fetchSynonymWord(word: String, completion: @escaping (Result<[Synonym], NetworkError>) -> Void)
  func translateText(text: String, targetLang: String, completion: @escaping (Result<TranslateResponse, NetworkError>) -> Void)
}

extension API: WordServiceProtocol {

  func fetchWord(word: String, completion: @escaping (Result<[WordResponse], NetworkError>) -> Void) {
    exequteRequestFor(
      word: word,
      baseURL: wordURL,
      completion: completion
    )
  }

  func fetchSynonymWord(word: String, completion: @escaping (Result<[Synonym], NetworkError>) -> Void) {
    exequteRequestFor(
      word: word,
      baseURL: synonymURL,
      completion: completion
    )
  }

  func translateText(text: String, targetLang: String, completion: @escaping (Result<TranslateResponse, NetworkError>) -> Void) {
    let parameters: [String: Any] = [
      "text": [text],
      "target_lang": targetLang
    ]

    let headers: [String: String] = [
      "Authorization": "DeepL-Auth-Key \(deepLAuthKey)",
      "Content-Type": "application/json"
    ]
    exequteRequestFor(
      word: "",
      parameters: parameters,
      headers: headers,
      method: .post,
      baseURL: deepLTranslateURL,
      completion: completion
    )
  }
}
