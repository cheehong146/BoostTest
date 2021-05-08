//
//  ContactDetailCell.swift
//  BoostTest
//
//  Created by Lan Chee Hong on 08/05/2021.
//

import UIKit

protocol ContactDetailCellInterface {
    func onNextKeyboardPress(type: ContactDetailTableDataRow?)
}

class ContactDetailCell: UITableViewCell {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    var fieldType: ContactDetailTableDataRow?
    var delegate: ContactDetailCellInterface?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func updateUI(type: ContactDetailTableDataRow?, labelText: String, textFieldValue: String = "") {
        
        label.text = labelText
        self.fieldType = type
        
        
        guard let type = type else { return }
        switch type {
        case .firstName:
            textField.placeholder = TEXT_FIRST_NAME_PLACEHOLDER
        case .lastName:
            textField.placeholder = TEXT_LAST_NAME_PLACEHOLDER
        case .email:
            textField.placeholder = TEXT_EMAIL_PLACEHOLDER
        case .phoneNum:
            textField.placeholder = TEXT_PHONE_NUM_PLACEHOLDER
        }
        
        if !textFieldValue.isEmpty {
            textField.text = textFieldValue
        }
        
        // Keyboard type set
        switch type {
        case .firstName, .lastName:
            textField.keyboardType = .default
        case .email:
            textField.keyboardType = .emailAddress
        case .phoneNum:
            textField.keyboardType = .phonePad
        }
        textField.returnKeyType = .next
        textField.delegate = self
    }
    
}

// MARK: - UITextFieldDelegate
extension ContactDetailCell: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.delegate?.onNextKeyboardPress(type: self.fieldType)
        return true
    }
}
