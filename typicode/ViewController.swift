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

class ViewController: UIViewController {
  
  var stackView: UIStackView = UIStackView()

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    
    view.addSubview(stackView)
    stackView.axis = .vertical
    stackView.distribution = .fillProportionally
    stackView.spacing = 4
    
    
    let userLabel = UILabel()
    let titleLabel = UILabel()
    let bodyLabel = UILabel()
    
    view.addSubview(userLabel)
    view.addSubview(titleLabel)
    view.addSubview(bodyLabel)
    
    [userLabel, titleLabel, bodyLabel].forEach{
      $0.numberOfLines = 0
      stackView.addArrangedSubview($0)
    }
    
    stackView.snp.makeConstraints { make in
      make.top.equalToSuperview().offset(10)
      make.leading.equalToSuperview().offset(10)
      make.trailing.equalToSuperview().offset(-10)
      make.bottom.equalToSuperview().offset(-10)
    }
    
    userLabel.text = "123"
    titleLabel.text = "sunt aut facere repellat provident occaecati excepturi optio reprehenderit"
    bodyLabel.text = "quia et suscipit suscipit recusandae consequuntur expedita et cum reprehenderit molestiae ut ut quas totam nostrum rerum est autem sunt rem eveniet architecto"
    
    BasicNetworkService().load(resource: ArrayAPIResource<Post>(requestAPIType: BasicAPIRequest.posts))
      .subscribe { post in
        post.element
      }
      .dispose()
  }


}

