//
//  ContactViewCell.swift
//  Contacts
//
//  Created by Kevin Zeckser on 6/13/16.
//  Copyright © 2016 Kevin Zeckser. All rights reserved.
//

import UIKit

class ContactViewCell: UITableViewCell {
    
    @IBOutlet weak var contactName: UILabel!
    @IBOutlet weak var contactPhoneNumber: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
