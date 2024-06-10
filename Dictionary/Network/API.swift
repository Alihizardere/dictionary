//
//  API.swift
//  Dictionary
//
//  Created by alihizardere on 6.06.2024.
//

import Foundation

enum RequestMethod: String {
  case get = "GET"
  case post = "POST"
}

final class API {

  static let shared: API = {
    let instance = API()
    return instance
  }()

  var wordURL = "https://api.dictionaryapi.dev/api/v2/entries/en/"
  var synonymURL = "https://api.datamuse.com/words?rel_syn="

  private var service: NetworkService

  init(service: NetworkService = NetworkManager()) {
    self.service = service
  }
}

extension API {

  func isConnectedToInternet() -> Bool {
    Reachability.isConnectedToNetwork()
  }

  func prepareURLRequestFor(
    word: String,
    parameters: [String: Any]? = nil,
    headers: [String: String]? = nil,
    method: RequestMethod = .get,
    baseURL: String
  ) -> URLRequest? {

    let urlString = baseURL + word
    guard let url = URL(string: urlString) else { return nil }

    var request = URLRequest(url: url)

    if let params = parameters {
      if method == .get {
        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
          return nil
        }
        let queryItems = params.map {
          URLQueryItem(name: $0.key, value: String(describing: $0.value))
        }
        urlComponents.queryItems = (urlComponents.queryItems ?? []) + queryItems
        guard let newUrl = urlComponents.url else { return nil }
        request = URLRequest(url: newUrl)
      } else {
        let jsonData = try? JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
        request.httpBody = jsonData
      }
    }

    request.httpMethod = method.rawValue
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")

    if let requestHeaders = headers {
      for (field, value) in requestHeaders {
        request.setValue(value, forHTTPHeaderField: field)
      }
    }

    return request
  }

  func exequteRequestFor<T: Decodable>(
    word: String,
    parameters: [String: Any]? = nil,
    headers: [String: String]? = nil,
    method: RequestMethod = .get,
    baseURL: String,
    completion: @escaping (Result<T, NetworkError>) -> Void
  ) {
    if let urlRequest = prepareURLRequestFor(
      word: word,
      parameters: parameters,
      headers: headers,
      method: method,
      baseURL: baseURL
    ) {
      service.execute(urlRequest: urlRequest, completion: completion)
    } else {
      completion(.failure(.invalidRequest))
    }
  }
}
