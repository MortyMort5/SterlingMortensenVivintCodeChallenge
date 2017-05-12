//
//  UserTableViewCell.swift
//  VivintProject
//
//  Created by Sterling Mortensen on 5/12/17.
//  Copyright © 2017 Sterling Mortensen. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {

    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    var users: User? {
        didSet {
            updateViews()
        }
    }
    
    func updateViews() {
        guard let users = users else { return }
        phoneNumberLabel.text = users.phoneNumber
        emailLabel.text = users.email
        lastNameLabel.text = users.lastName
        firstNameLabel.text = users.firstName
        profileImageView.image = users.profileImage
    }
}
