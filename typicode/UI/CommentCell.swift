//
//  CommentCell.swift
//  typicode
//
//  Created by jinhyuk on 2021/07/15.
//

import Foundation
import UIKit

class CommentCell: UITableViewCell {

  private let postIdLabel = UILabel()
  private let idLabel = UILabel()
  private let nameLabel = UILabel()
  private let emailLabel = UILabel()
  private let bodyLabel = UILabel()
  
  private let labelsStackView = UIStackView()

  override func layoutSubviews() {
    super.layoutSubviews()
    guard contentView.subviews.isEmpty else {
      return
    }
    setupLabels()
    layoutUI()
  }

  private func layoutUI() {
    [idLabel, postIdLabel, nameLabel, emailLabel, bodyLabel].forEach {
      labelsStackView.addArrangedSubview($0)
    }
    contentView.addSubview(labelsStackView)
    labelsStackView.spacing = 8
    labelsStackView.alignment = .fill
    labelsStackView.axis = .vertical
    labelsStackView.distribution = .fillProportionally
    labelsStackView.snp.makeConstraints { (make) in
      make.top.equalToSuperview().offset(20)
      make.leading.equalToSuperview().offset(20)
      make.bottom.equalToSuperview().offset(-20)
      make.right.equalToSuperview().offset(-20)
    }
  }

  private func setupLabels() {
    [idLabel, postIdLabel, nameLabel, emailLabel, bodyLabel].forEach {
      $0.numberOfLines = 0
    }
    idLabel.font = UIFont.boldSystemFont(ofSize: 12)
    postIdLabel.font = UIFont.italicSystemFont(ofSize: 14)
    nameLabel.font = UIFont.boldSystemFont(ofSize: 16)
    emailLabel.font = UIFont.systemFont(ofSize: 12)
    bodyLabel.font = UIFont.systemFont(ofSize: 16)
  }

  func configureWith(_ comment: Comment) {
    idLabel.text = "ID: \(comment.id)"
    postIdLabel.text = "Post ID: \(comment.postId)"
    nameLabel.text = comment.name
    emailLabel.text = comment.email
    bodyLabel.text = comment.body
    layoutIfNeeded()
  }
}

