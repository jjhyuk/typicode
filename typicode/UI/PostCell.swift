//
//  PostCell.swift
//  typicode
//
//  Created by jinhyuk on 2021/07/13.
//

import UIKit

class PostCell: UITableViewCell {

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
    [titleLabel, bodyLabel].forEach {
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
    [titleLabel, bodyLabel].forEach {
      $0.numberOfLines = 0
    }
    titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
    bodyLabel.font = UIFont.systemFont(ofSize: 16)
  }

  func configureWith(_ post: Post) {
    titleLabel.text = post.title
    bodyLabel.text = post.body
    layoutIfNeeded()
  }
}

