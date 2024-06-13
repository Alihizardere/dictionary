//
//  TranslateResponse.swift
//  Dictionary
//
//  Created by alihizardere on 12.06.2024.
//

import Foundation

struct TranslateResponse: Decodable {
    let translations: [Translation]
}

struct Translation: Decodable {
    let detected_source_language: String
    let text: String
}
