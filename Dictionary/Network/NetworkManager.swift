//
//  NetworkManager.swift
//  Dictionary
//
//  Created by alihizardere on 6.06.2024.
//

import Foundation

enum NetworkError: Error {

  case invalidRequest
  case requestFailed
  case jsonDecodedError
  case customError(Error)

  var localizedDescription: String {
    switch self {
    case .invalidRequest:
      return "The request is invalid. Please check your request and try again."
    case .requestFailed:
      return "The request failed. Please check your internet connection and try again."
    case .jsonDecodedError:
      return "There was an error decoding the data. Please check the data and try again."
    case .customError(let error):
      return error.localizedDescription
    }
  }
}

protocol NetworkService {
  func execute<T: Decodable>(
    urlRequest: URLRequest,
    completion: @escaping(Result<T, NetworkError>) -> Void
  )
}

final class NetworkManager {
  private let session: URLSession

  init(session: URLSession = URLSession(configuration: .default)) {
    self.session = session
  }
}

extension NetworkManager: NetworkService {

  func execute<T>(urlRequest: URLRequest, completion: @escaping (Result<T, NetworkError>) -> Void) where T : Decodable {

    let task = session.dataTask(with: urlRequest) { data, response, error in

      if let error {
        completion(.failure(.customError(error)))
      } else if let data {
        do {
          let responseObj = try JSONDecoder().decode(T.self, from: data)
          completion(.success(responseObj))
        } catch {
          completion(.failure(.jsonDecodedError))
        }
      } else {
        completion(.failure(.requestFailed))
      }
    }
    task.resume()
  }
}
