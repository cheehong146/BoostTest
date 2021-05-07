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
    
    // MARK: -  Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        // Do any additional setup after loading the view.
    }
    
    private func setupView() {
        
        tableView.delegate = self
        tableView.dataSource = self
        ContactCell.registerNibCell(tableView)
    }

}

// MARK: -  UITableViewDelegate, UITableViewDataSource
extension ContactListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ContactCell.reuseIdentifier(), for: indexPath) as? ContactCell else { return .init() }
        cell.updateUI(name: "Test", profilePicture: nil)
        return cell
    }
    
    
}
