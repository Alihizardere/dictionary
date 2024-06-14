//
//  FavoriteWordCell.swift
//  Dictionary
//
//  Created by alihizardere on 13.06.2024.
//

import UIKit

protocol FavoriteWordCellDelegate: AnyObject {
  func deleteButtonTapped(at indexPath: IndexPath)
}

class FavoriteWordCell: UITableViewCell {

  // MARK: - Properties
  @IBOutlet weak var wordLabel: UILabel!
  @IBOutlet weak var cardView: UIView!
  @IBOutlet weak var deleteButton: UIButton!
  static let identifier = "FavoriteWordCell"
  weak var delegate: FavoriteWordCellDelegate?
  var indexPath: IndexPath?

  override func awakeFromNib() {
    super.awakeFromNib()
    cardView.layer.cornerRadius = 20
    cardView.layer.borderWidth = 2
    cardView.layer.borderColor = UIColor.main.cgColor
    deleteButton.accessibilityIdentifier = "deleteButton"
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)

  }

  @IBAction func deleteButtonTapped(_ sender: Any) {
    guard let indexPath = indexPath else { return }
    delegate?.deleteButtonTapped(at: indexPath)
  }

}
