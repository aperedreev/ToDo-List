//
//  ItemTableViewCell.swift
//  ToDo List
//
//  Created by Aleksey Peredreev on 10.09.2019.
//  Copyright © 2019 Aleksey Peredreev. All rights reserved.
//

import UIKit

class ItemTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
