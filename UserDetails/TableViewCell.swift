//
//  TableViewCell.swift
//  UserDetails
//
//  Created by Dadha Kumar on 12/5/20.
//  Copyright © 2020 Dadha Kumar. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var nameOutlet: UILabel!
    @IBOutlet weak var genderOutlet: UILabel!
    @IBOutlet weak var emailOutlet: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
