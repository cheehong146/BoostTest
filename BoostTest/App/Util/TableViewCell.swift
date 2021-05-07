//
//  TableViewCell.swift
//  BoostTest
//
//  Created by Lan Chee Hong on 08/05/2021.
//

import UIKit

extension UITableViewCell {
    
    class func reuseIdentifier() -> String {
        return "\(self)"
    }
    
    class func nib() -> UINib {
        return UINib(nibName: reuseIdentifier(), bundle: nil)
    }
    
    class func registerNibCell(_ tableView: UITableView) {
        tableView.register(nib(), forCellReuseIdentifier: reuseIdentifier())
    }
    
    class func registerNibCell(_ tableView: UITableView, reuseIdentifier: String) {
        tableView.register(nib(), forCellReuseIdentifier: reuseIdentifier)
    }
    
    class func registerClass(_ tableView: UITableView) {
        tableView.register(self, forCellReuseIdentifier: reuseIdentifier())
    }
    
    class func registerClass(_ tableView: UITableView, reuseIdentifier: String) {
        tableView.register(self, forCellReuseIdentifier: reuseIdentifier)
    }
}
