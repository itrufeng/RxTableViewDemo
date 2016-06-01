//
//  ViewController.swift
//  RxDelegate
//
//  Created by Jian Zhang on 5/14/16.
//  Copyright © 2016 Jian Zhang. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
  @IBOutlet weak var tableView: UITableView!
  var formDataSource = FormDataSource()
  
  var forms = [
    Form(title: "title", value: "1"),
    Form(title: "name", value: "2"),
    Form(title: "age", value: "3"),
    Form(title: "phone", value: "4"),
    Form(title: "email", value: "5"),
    Form(title: "twitter", value: "6"),
    Form(title: "facebook", value: "7"),
    Form(title: "weibo", value: "8"),
    Form(title: "wechat", value: "9"),
    Form(title: "line", value: "10"),
    Form(title: "skype", value: "11"),
    Form(title: "github", value: "12"),
    Form(title: "linkin", value: "13"),
    Form(title: "blog", value: "14")
  ]
  
  let bag = DisposeBag()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    formDataSource.bind(forms).subscribeNext { forms -> Void in
      print(forms)
    }.addDisposableTo(bag)
    tableView.dataSource = formDataSource
    tableView.rowHeight = UITableViewAutomaticDimension
    tableView.estimatedRowHeight = 50
  }
}

