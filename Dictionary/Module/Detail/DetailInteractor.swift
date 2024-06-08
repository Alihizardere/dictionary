//
//  DetailInteractor.swift
//  Dictionary
//
//  Created by alihizardere on 8.06.2024.
//

import Foundation

protocol DetailInteractorProtocol {
}

protocol DetailInteractorOutputProtocol {

}

final class DetailInteractor {
  var output: DetailInteractorOutputProtocol?
}

extension DetailInteractor: DetailInteractorProtocol {

}
