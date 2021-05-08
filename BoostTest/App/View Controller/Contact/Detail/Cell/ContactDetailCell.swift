//
//  ContactDetailCell.swift
//  BoostTest
//
//  Created by Lan Chee Hong on 08/05/2021.
//

import UIKit

class ContactDetailCell: UITableViewCell {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateUI(labelText: String, textFieldValue: String = "") {
        label.text = labelText
        if !textFieldValue.isEmpty {
            textField.text = textFieldValue
        }
    }
    
}
