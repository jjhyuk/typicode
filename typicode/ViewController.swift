//
//  ViewController.swift
//  typicode
//
//  Created by jinhyuk on 2021/07/09.
//

import UIKit
import SnapKit
import RxSwift
import RxAlamofire
import RxCocoa

class ViewController: UIViewController {
  
  let tableView: UITableView = UITableView()
  
  var viewModel: MainViewControllerViewModelType = MainViewControllerViewModel(postUseCase: PostUseCase(postRepo: PostRepo()))
  
//  var viewModel: MainViewControllerViewReactorKit = MainViewControllerViewReactorKit(postUseCase: PostUseCase(postRepo: PostRepo()))

  private let disposeBag: DisposeBag = DisposeBag()

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
   
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
    
    tableView.register(PostCell.self, forCellReuseIdentifier: "test")
    tableView.rowHeight = UITableView.automaticDimension
    tableView.estimatedRowHeight = 100

  }
  
  func bindTableView() {

viewModel.fetchDataSubject
  .bind(to: tableView.rx.items) { tableView, row, item in
    let cell = tableView.dequeueReusableCell(withIdentifier: "test") as! PostCell
    cell.configureWith(item)
    return cell
  }
  .disposed(by: disposeBag)

tableView.rx.modelSelected(Post.self)
  .do { _ in
    self.tableView.indexPathsForSelectedRows?.forEach {
      self.tableView.deselectRow(at: $0, animated: true)
    }
  }
  .subscribe(viewModel.transitionViewSubject)
  .disposed(by: disposeBag)
    
//    tableView.rx.itemSelected
//      .map{ MainViewControllerViewReactorKit.Action.selectRow($0.row) }
//      .bind(to: viewModel.action)
//      .disposed(by: disposeBag)
//
//    viewModel.state.map { $0.indexPathRow }
//      .subscribe { print(" \(String(describing: $0.element!))") }
//      .disposed(by: disposeBag)
  }
}



