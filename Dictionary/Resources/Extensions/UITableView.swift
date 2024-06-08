//
//  UITableView.swift
//  Dictionary
//
//  Created by alihizardere on 8.06.2024.
//

import UIKit

extension UITableView {
  func setEmptyView(_ title: String, message: String) {
    let emptyView = UIView(frame: CGRect(x: self.center.x, y: self.center.y, width: self.bounds.size.width, height: self.bounds.size.height))

    let titleLabel = UILabel()
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    titleLabel.textColor = .systemOrange
    titleLabel.font = .systemFont(ofSize: 18, weight: .medium)
    titleLabel.text = title
    titleLabel.textAlignment = .center
    titleLabel.numberOfLines = 0

    let messageLabel = UILabel()
    messageLabel.translatesAutoresizingMaskIntoConstraints = false
    messageLabel.textColor = .lightGray
    messageLabel.font = .systemFont(ofSize: 16, weight: .medium)
    messageLabel.text = message
    messageLabel.textAlignment = .center
    messageLabel.numberOfLines = 0

    emptyView.addSubview(titleLabel)
    emptyView.addSubview(messageLabel)

    NSLayoutConstraint.activate([
      titleLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor),
      titleLabel.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor),

      messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
      messageLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor),
    ])

    self.backgroundView = emptyView
    self.separatorStyle = .none
  }

  func restore() {
    self.backgroundView = nil
    self.separatorStyle = .singleLine
  }
}
