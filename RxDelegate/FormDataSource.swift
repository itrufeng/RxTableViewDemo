//
//  FormDataSource.swift
//  RxDelegate
//
//  Created by Jian Zhang on 6/1/16.
//  Copyright © 2016 Jian Zhang. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

class FormDataSource: NSObject, UITableViewDataSource {
  private var observer: (AnyObserver<[Form]>)?
  private var forms: [Form]?
  
  func bind(forms: [Form]) -> Observable<[Form]> {
    self.forms = forms
    return Observable.create{ observer -> Disposable in
      self.observer = observer
      return NopDisposable.instance
    }
  }
  
  // MARK: delegate
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return forms?.count ?? 0
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier(TextFieldFormCell.identifier(), forIndexPath: indexPath)
    
    guard let form = forms?[indexPath.row] else {
      return cell
    }
    
    if let textFieldFormCell = cell as? TextFieldFormCell {
      textFieldFormCell.configure(form)
      textFieldFormCell.didChange = { [weak self] text, cell -> () in
        guard let row = tableView.indexPathForCell(cell)?.row,
          form = self?.forms?[row] else {
            return
        }
        self?.forms?[row] = Form(title: form.title, value: text)
        guard let forms = self?.forms else {
          return
        }
        self?.observer?.onNext(forms)
      }
    }
    
    return cell
  }
}
