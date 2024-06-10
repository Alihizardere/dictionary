//
//  Word.swift
//  Dictionary
//
//  Created by alihizardere on 6.06.2024.
//

import Foundation

struct WordResponse: Decodable {
    let word: String?
    let phonetic: String?
    let phonetics: [Phonetic]?
    let meanings: [Meaning]?
    let license: License?
    let sourceUrls: [String]?
}

struct Phonetic: Decodable {
    let text: String?
    let audio: String?
    let sourceUrl: String?
    let license: License?
}

struct Meaning: Decodable {
    let partOfSpeech: String?
    let definitions: [Definition]
    let synonyms: [String]?
    let antonyms: [String]?
}

struct Definition: Decodable {
    let definition: String?
    let example: String?
    let synonyms: [String]?
    let antonyms: [String]?
}

struct License: Decodable {
    let name: String?
    let url: String?
}
