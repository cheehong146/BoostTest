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
    }

    // MARK: -  Actions
    @objc func onCancelButtonPress(_ gesture: UITapGestureRecognizer) {
        self.popFromNVC()
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
            
        default:
            return
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
        cell.updateUI(labelText: field.0, textFieldValue: field.1)
        return cell
    }
}
