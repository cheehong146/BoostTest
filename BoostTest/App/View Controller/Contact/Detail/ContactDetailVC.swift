//
//  ContactDetailVC.swift
//  BoostTest
//
//  Created by Lan Chee Hong on 08/05/2021.
//

import UIKit

protocol ContactDetailInterface {
    func didAddNewContact()
}

class ContactDetailVC: UIViewController {

    // MARK: -  IBOutlets
    @IBOutlet weak var profileImageView : UIImageView!
    @IBOutlet weak var tableView        : UITableView!
    
    var viewModel: ContactDetailViewModel!
    var delegate: ContactDetailInterface?
    
    // MARK: -  Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    private func setupView() {
        
        tableView.delegate = self
        tableView.dataSource = self
        ContactDetailCell.registerNibCell(tableView)
        
        // Bar button
        let cancelBarBtn = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(onCancelButtonPress))
        cancelBarBtn.tintColor = AppTheme.primaryColor
        navigationItem.leftBarButtonItem = cancelBarBtn
        
        let saveBarBtn = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(onSaveButtonPress))
        saveBarBtn.tintColor = AppTheme.primaryColor
        navigationItem.rightBarButtonItem = saveBarBtn
        
        let profileImageViewHeight = profileImageView.frame.height
        profileImageView.layer.cornerRadius = profileImageViewHeight / 2
        profileImageView.image = UIImage(color: AppTheme.primaryColor, size: CGSize(width: profileImageViewHeight, height: profileImageViewHeight))
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissKeybaord(_:))))
    }

    // MARK: -  Actions
    @objc func onCancelButtonPress(_ gesture: UITapGestureRecognizer) {
        self.popFromNVC()
    }
    
    
    @objc func dismissKeybaord(_ gesture: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @objc func onSaveButtonPress(_ gesture: UITapGestureRecognizer) {
        var updatedFieldData: [String] = []
       
        
        for sectionIndex in 0..<viewModel.getSectionCount() {
            for rowIndex in 0..<viewModel.getNumOfRowInSection(at: sectionIndex) {
                guard let cell = tableView.cellForRow(at: IndexPath(row: rowIndex, section: sectionIndex)) as? ContactDetailCell else { return }
                updatedFieldData.append(cell.textField.text ?? "")
            }
        }
        
        
        let id = viewModel.getState() == .add ? viewModel.generateNounceID(): viewModel.getProfile()?.id
        let updatedProfile = Profile(
            id: id ?? "",
            firstName: updatedFieldData[0],
            lastName: updatedFieldData[1],
            email: updatedFieldData[2],
            phone: updatedFieldData[3])
        
        do {
            try viewModel.validateProfile(updatedProfile)
        } catch {
            if let error = error as? ContactDetailError {
                DialogHelper.showAlert(type: .notice, errorMessage: error.errorMessage)
            } else {
                DialogHelper.showAlert(type: .notice, errorMessage: error.localizedDescription)
            }
            return
        }
        
        switch viewModel.getState() {
        
        case .add:
            viewModel.addProfile(updatedProfile)
            self.delegate?.didAddNewContact()
            
        case .edit:
            viewModel.updateProfile(updatedProfile)
        }
        
        self.popFromNVC()
    }
}

// MARK: -  UITableViewDelegate, UITableViewDataSource
extension ContactDetailVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.getSectionCount()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.getSectionTitle(at: section)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumOfRowInSection(at: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ContactDetailCell.reuseIdentifier()) as? ContactDetailCell else { return .init() }
        let field = viewModel.getFields(at: indexPath)
        cell.updateUI(type: field.0, labelText: field.1, textFieldValue: field.2)
        cell.delegate = self
        return cell
    }
}

// MARK: - ContactDetailCellInterface
extension ContactDetailVC: ContactDetailCellInterface {
    
    func onNextKeyboardPress(type: ContactDetailTableDataRow?) {
        guard let type = type else { return }
        guard let cell = tableView.cellForRow(at: viewModel.getIndexPath(from: type.rawValue)) as? ContactDetailCell else { return }
        
        switch type {
        case .firstName, .lastName, .email:
            cell.textField.resignFirstResponder()
            
            guard let nextCell = tableView.cellForRow(at: viewModel.getIndexPath(from: type.rawValue + 1)) as? ContactDetailCell else { return }
            
            nextCell.textField.becomeFirstResponder()
            
        case .phoneNum:
            return
        }
    }
}
