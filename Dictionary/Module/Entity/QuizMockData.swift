//
//  QuizMockData.swift
//  Dictionary
//
//  Created by alihizardere on 11.06.2024.
//

import Foundation

struct QuizQuestion {
    let question: String
    let optionA: String
    let optionB: String
    let optionC: String
    let optionD: String
    let correctAnswer: String
}

struct MockQuizData {
    static let questions: [QuizQuestion] = [
        QuizQuestion(
            question: "What is the meaning of the word \"gregarious\"?",
            optionA: "Shy",
            optionB: "Social",
            optionC: "Angry",
            optionD: "Sad",
            correctAnswer: "Social"
        ),
        QuizQuestion(
            question: "What is the synonym of the word \"alleviate\"?",
            optionA: "Aggravate",
            optionB: "Worsen",
            optionC: "Relieve",
            optionD: "Intensify",
            correctAnswer: "Relieve"
        ),
        QuizQuestion(
            question: "What does the word \"ephemeral\" mean?",
            optionA: "Permanent",
            optionB: "Temporary",
            optionC: "Infinite",
            optionD: "Ancient",
            correctAnswer: "Temporary"
        ),
        QuizQuestion(
            question: "What is the meaning of the word \"obfuscate\"?",
            optionA: "Clarify",
            optionB: "Simplify",
            optionC: "Confuse",
            optionD: "Illuminate",
            correctAnswer: "Confuse"
        ),
        QuizQuestion(
            question: "What is the synonym of the word \"prodigious\"?",
            optionA: "Small",
            optionB: "Tiny",
            optionC: "Modest",
            optionD: "Enormous",
            correctAnswer: "Enormous"
        ),
        QuizQuestion(
            question: "What does the word \"capricious\" mean?",
            optionA: "Predictable",
            optionB: "Stable",
            optionC: "Fickle",
            optionD: "Constant",
            correctAnswer: "Fickle"
        ),
        QuizQuestion(
            question: "What is the meaning of the word \"tenacious\"?",
            optionA: "Weak",
            optionB: "Persistent",
            optionC: "Indifferent",
            optionD: "Yielding",
            correctAnswer: "Persistent"
        ),
        QuizQuestion(
            question: "What is the synonym of the word \"acrimonious\"?",
            optionA: "Sweet",
            optionB: "Bitter",
            optionC: "Harmonious",
            optionD: "Peaceful",
            correctAnswer: "Bitter"
        ),
        QuizQuestion(
            question: "What does the word \"ubiquitous\" mean?",
            optionA: "Rare",
            optionB: "Scarce",
            optionC: "Omnipresent",
            optionD: "Hidden",
            correctAnswer: "Omnipresent"
        ),
        QuizQuestion(
            question: "What is the meaning of the word \"venerate\"?",
            optionA: "Disrespect",
            optionB: "Ignore",
            optionC: "Honor",
            optionD: "Disregard",
            correctAnswer: "Honor"
        )
    ]
}
