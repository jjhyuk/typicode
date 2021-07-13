//
//  PostCell.swift
//  typicode
//
//  Created by jinhyuk on 2021/07/13.
//

import UIKit

class PostCell: UITableViewCell {

  private let userIdLabel = UILabel()
  private let idLabel = UILabel()
  private let titleLabel = UILabel()
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
    [idLabel, userIdLabel, titleLabel, bodyLabel].forEach {
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
    [idLabel, userIdLabel, titleLabel, bodyLabel].forEach {
      $0.numberOfLines = 0
    }
    idLabel.font = UIFont.boldSystemFont(ofSize: 12)
    userIdLabel.font = UIFont.italicSystemFont(ofSize: 14)
    titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
    bodyLabel.font = UIFont.systemFont(ofSize: 16)
  }

  func configureWith(_ post: Post) {
    idLabel.text = "Post ID: \(post.id)"
    userIdLabel.text = "User ID: \(post.userId)"
    titleLabel.text = post.title
    bodyLabel.text = post.body
    layoutIfNeeded()
  }
}

