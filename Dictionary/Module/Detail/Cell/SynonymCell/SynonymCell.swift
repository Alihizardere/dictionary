//
//  SynonymCell.swift
//  Dictionary
//
//  Created by alihizardere on 10.06.2024.
//

import UIKit

protocol SynonymCellDelegate: AnyObject {
    func synonymButtonTapped(_ synonym: String)
}

class SynonymCell: UITableViewCell {

  // MARK: - Properties
  static let identifier = "SynonymCell"
  @IBOutlet weak var stackView: UIStackView!
  weak var delegate: SynonymCellDelegate?

  // MARK: - Lifecycle
  override func awakeFromNib() {
    super.awakeFromNib()
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)

  }

  // MARK: - Actions && Functions
  @objc func synonymButtonTapped(_ sender: UIButton) {
    if let synonym = sender.titleLabel?.text {
      delegate?.synonymButtonTapped(synonym)
    }
  }

  func setupSynonymCell(synonyms: [Synonym]) {
    stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
    let topSynonyms = Array(synonyms.prefix(5))

    for synonym in topSynonyms {
      let button = UIButton(type: .system)
      button.setTitle(synonym.word, for: .normal)
      button.backgroundColor = .systemGray5
      button.layer.cornerRadius = 5
      button.addTarget(self, action: #selector(synonymButtonTapped), for: .touchUpInside)
      stackView.addArrangedSubview(button)
    }
  }
}
