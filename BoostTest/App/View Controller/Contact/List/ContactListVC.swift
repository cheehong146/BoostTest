//
//  ContactListVC.swift
//  BoostTest
//
//  Created by Lan Chee Hong on 08/05/2021.
//

import UIKit

class ContactListVC: UIViewController {
    
    // MARK: -  IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: ContactListViewModel {
        return ContactListViewModel()
    }
    
    // MARK: -  Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    private func setupView() {
        self.title = "Contacts"
        
        tableView.delegate = self
        tableView.dataSource = self
        ContactCell.registerNibCell(tableView)
        
        let addContactBarBtn = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(onAddContactBtnPress))
        addContactBarBtn.tintColor = AppTheme.primaryColor
        navigationItem.rightBarButtonItem = addContactBarBtn
    }
    
    // MARK: -  Actions
    @objc func onAddContactBtnPress(_ gesture: UITapGestureRecognizer) {
        self.openAddContact()
    }
}

// MARK: -  UITableViewDelegate, UITableViewDataSource
extension ContactListVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getListOfContacts().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ContactCell.reuseIdentifier(), for: indexPath) as? ContactCell else { return .init() }
        let profile = viewModel.getListOfContacts()[indexPath.row]
        cell.updateUI(name: "\(profile.firstName ?? "") \(profile.lastName ?? "")", profilePicture: nil)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let profile = viewModel.getListOfContacts()[indexPath.row]
        self.openEditContact(profile: profile)
    }
}
