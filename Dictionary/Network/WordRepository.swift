//
//  WordRepository.swift
//  Dictionary
//
//  Created by alihizardere on 8.06.2024.
//

import UIKit
import CoreData

protocol WordRepositoryProtocol {
  func saveWord(word: String)
  func fetchWords() -> [String]?
  func deleteWord(indexPath: IndexPath)
}

final class WordRepository: WordRepositoryProtocol {

  private let appDelegate = UIApplication.shared.delegate as! AppDelegate

  func saveWord(word: String) {

    let context = appDelegate.persistentContainer.viewContext
    let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Words")
    fetchRequest.predicate = NSPredicate(format: "word == %@", word)

    do {
      let results = try context.fetch(fetchRequest)
      if results.isEmpty {
        let newWord = NSEntityDescription.insertNewObject(forEntityName: "Words", into: context)
        newWord.setValue(word, forKey: "word")
        try context.save()
      }
    } catch {
      print("Save Error")
    }
  }

  func fetchWords() -> [String]? {

    let context = appDelegate.persistentContainer.viewContext
    let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Words")

    do {
      let results = try context.fetch(fetchRequest)
      if !results.isEmpty {
        var words = [String]()
        for result in results as! [NSManagedObject] {
          if let word = result.value(forKey: "word") as? String {
            words.append(word)
          }
        }
        return words.reversed()
      } else {
        return []
      }
    } catch {
      print("Fetch Error")
      return []
    }
  }

  func deleteWord(indexPath: IndexPath) {

    let context = appDelegate.persistentContainer.viewContext
    let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Words")

    do {
      let results = try context.fetch(fetchRequest)
      let reversedResults = Array(results.reversed())
      if let deleteItem = reversedResults[indexPath.row] as? NSManagedObject {
        context.delete(deleteItem)
        try context.save()
      }
    } catch {
      print("Delete Error")
    }
  }
}
