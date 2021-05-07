//
//  ContactCell.swift
//  BoostTest
//
//  Created by Lan Chee Hong on 08/05/2021.
//

import UIKit

class ContactCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    public func updateUI(name: String, profilePicture: UIImage?) {
        nameLabel.text = name
        
        let pictureHeight = profileImageView.frame.size.height
        profileImageView.layer.cornerRadius = pictureHeight / 2
        
        if let profilePicture = profilePicture {
            profileImageView.image = profilePicture
        } else {
            profileImageView.image = UIImage(color: AppTheme.primaryColor, size: CGSize(width: pictureHeight, height: pictureHeight))
        }
    }
}
