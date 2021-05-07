//
//  ContactDetailVC.swift
//  BoostTest
//
//  Created by Lan Chee Hong on 08/05/2021.
//

import UIKit

class ContactDetailVC: UIViewController {

    // MARK: -  IBOutlets
    @IBOutlet weak var profileImageView : UIImageView!
    @IBOutlet weak var tableView        : UITableView!
    
    // MARK: -  Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    private func setupView() {
        self.title = "Contacts"
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // Bar button
        let cancelBarBtn = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(onCancelButtonPress))
        cancelBarBtn.tintColor = AppTheme.primaryColor
        navigationItem.leftBarButtonItem = cancelBarBtn
        
        let saveBarBtn = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(onSaveButtonPress))
        saveBarBtn.tintColor = AppTheme.primaryColor
        navigationItem.rightBarButtonItem = saveBarBtn
        
        profileImageView.layer.cornerRadius = profileImageView.frame.height / 2
    }

    // MARK: -  Actions
    @objc func onCancelButtonPress(_ gesture: UITapGestureRecognizer) {
        // TODO cancel/dismiss action
        print("😀")
    }
    
    @objc func onSaveButtonPress(_ gesture: UITapGestureRecognizer) {
        // TODO save contact action
        print("😀")
    }
}

// MARK: -  UITableViewDelegate, UITableViewDataSource
extension ContactDetailVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // TODO get data from VM
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // TODO get data from VM
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return .init()
    }
}
