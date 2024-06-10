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
}

extension API: WordServiceProtocol {

  func fetchWord(word: String, completion: @escaping (Result<[WordResponse], NetworkError>) -> Void) {
   exequteRequestFor(word: word, baseURL: wordURL, completion: completion)
  }

  func fetchSynonymWord(word: String, completion: @escaping (Result<[Synonym], NetworkError>) -> Void) {
    exequteRequestFor(word: word, baseURL: synonymURL, completion: completion)
  }
}
