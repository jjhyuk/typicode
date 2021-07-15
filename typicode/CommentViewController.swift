//
//  CommentViewController.swift
//  typicode
//
//  Created by jinhyuk on 2021/07/15.
//

import UIKit
import RxSwift
import ReactorKit
import RxCocoa

class CommentViewController: UIViewController {
  
  var post: Post
  
  let tableView: UITableView = UITableView()
  
  private let disposeBag: DisposeBag = DisposeBag()
  
  var viewModel: CommentViewControllerViewModelType!
  
  
  init(_ post: Post) {
    
    self.post = post
    
    super.init(nibName: nil, bundle: nil)
    
    viewModel = CommentViewControllerViewModel(postUseCase: PostUseCase(postRepo: PostRepo()), post: post)
    
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setUpTableView()
    bindTableView()
  }
  
  func setUpTableView() {
    tableView.backgroundColor = .white
    view.addSubview(tableView)
    
    tableView.snp.makeConstraints { make in
      make.top.equalToSuperview()
      make.leading.equalToSuperview()
      make.trailing.equalToSuperview()
      make.bottom.equalToSuperview()
    }
    
    tableView.register(CommentCell.self, forCellReuseIdentifier: "test")
    tableView.rowHeight = UITableView.automaticDimension
    tableView.estimatedRowHeight = 100
    
  }
  
  func bindTableView() {
    
    viewModel.fetchDataSubject
      .bind(to: tableView.rx.items) { tableView, row, item in
        let cell = tableView.dequeueReusableCell(withIdentifier: "test") as! CommentCell
        cell.configureWith(item)
        return cell
      }
      .disposed(by: disposeBag)
      
  }
  
}
