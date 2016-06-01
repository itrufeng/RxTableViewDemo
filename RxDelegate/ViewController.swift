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

class ViewController: UIViewController, UITableViewDataSource {
  @IBOutlet weak var tableView: UITableView!
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
    tableView.rowHeight = UITableViewAutomaticDimension
    tableView.estimatedRowHeight = 50
  }
  
  // MARK: delegate
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return forms.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let form = forms[indexPath.row]
    guard let cell = tableView.dequeueReusableCellWithIdentifier(TextFieldFormCell.identifier()) else {
      return UITableViewCell()
    }
    
    if let textFieldFormCell = cell as? TextFieldFormCell {
      textFieldFormCell.configure(form)
      textFieldFormCell.didChange = { [weak self] text, cell -> () in
        guard let row = self?.tableView.indexPathForCell(cell)?.row,
        form = self?.forms[row] else {
          return
        }
        self?.forms[row] = Form(title: form.title, value: text)
      }
    }
    
    return cell
  }
}

