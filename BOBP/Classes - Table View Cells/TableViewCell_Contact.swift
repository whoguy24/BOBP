//
//  ContactTableViewCell.swift
//  Auditions
//
//  Created by Warren O'Brien on 3/30/19.
//  Copyright © 2019 Warren O'Brien. All rights reserved.
//

import UIKit

class TableViewCell_Contact: UITableViewCell {

    @IBOutlet weak var contactLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
