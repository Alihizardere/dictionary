//
//  WordTypeCell.swift
//  Dictionary
//
//  Created by alihizardere on 9.06.2024.
//

import UIKit

class WordTypeCell: UITableViewCell {

  // MARK: - Properties
  static let identifier = "WordTypeCell"
  @IBOutlet weak var sectionTitleLabel: UILabel!
  @IBOutlet weak var sectionNumberLabel: UILabel!
  @IBOutlet weak var contentLabel: UILabel!
  @IBOutlet weak var exampleLabel: UILabel!
  @IBOutlet weak var exampleView: UIView!
  
  // MARK: - Lifecycle
  override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

  func configure(sectionKey: String, definition: Definition, indexPath: Int){
    sectionNumberLabel.text = "\(indexPath + 1)"
    sectionTitleLabel.text =  "- \(sectionKey)"
    contentLabel.text = definition.definition
    exampleLabel.text = definition.example
  }
}
