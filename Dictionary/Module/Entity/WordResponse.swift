//
//  Word.swift
//  Dictionary
//
//  Created by alihizardere on 6.06.2024.
//

import Foundation

// MARK: - WordResponse
struct WordResponse: Decodable {
    let word, phonetic: String?
    let phonetics: [Phonetic]?
    let meanings: [Meaning]?
    let license: License?
    let sourceUrls: [String]?
}

// MARK: - License
struct License: Decodable {
    let name: String?
    let url: String?
}

// MARK: - Meaning
struct Meaning: Decodable {
    let partOfSpeech: String?
    let definitions: [Definition]?
    let synonyms, antonyms: [String]?
}

// MARK: - Definition
struct Definition: Decodable {
    let definition: String?
    let antonyms: [String]?
    let example: String?
}

// MARK: - Phonetic
struct Phonetic: Decodable {
    let text: String?
    let audio: String?
    let sourceURL: String?
    let license: License?
}
