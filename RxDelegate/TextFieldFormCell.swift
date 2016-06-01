//
//  TextFieldFormCell.swift
//  RxDelegate
//
//  Created by Jian Zhang on 6/1/16.
//  Copyright © 2016 Jian Zhang. All rights reserved.
//

import UIKit

class TextFieldFormCell: UITableViewCell {
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var inputTextField: UITextField!
  var didChange: ((text: String, cell: UITableViewCell) -> ())?
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    titleLabel.text = ""
    inputTextField.text = ""
  }
  
  class func identifier() -> String {
    return "TextFieldFormCell"
  }
  
  func configure(form: Form) {
    titleLabel.text = form.title
    inputTextField.text = form.value
  }
  
  @IBAction func onChange(sender: UITextField) {
    guard let text = sender.text else {
      return
    }
    didChange?(text: text, cell: self)
  }
  
}
