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
  
  var viewModel: MainViewControllerViewModelType = MainViewControllerViewModel()
  
  let disposeBag: DisposeBag = DisposeBag()

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
    
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "test")
    tableView.rowHeight = UITableView.automaticDimension
    tableView.estimatedRowHeight = 100
  }
  
  func bindTableView() {
    viewModel.fetchDataSubject
      .bind(to: tableView.rx.items) { tableView, row, item in
        let cell = tableView.dequeueReusableCell(withIdentifier: "test")!
        cell.textLabel?.text = item.title
        return cell
      }
      .disposed(by: disposeBag)
    
    // test
    tableView.rx.itemSelected
      .subscribe { indexPath in
        self.viewModel.testTab()
      }
      .disposed(by: disposeBag)
  }
}



