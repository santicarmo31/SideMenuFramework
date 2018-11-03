//
//  SideMenuTableViewCell.swift
//  SideMenuExample
//
//  Created by Santiago Carmona Gonzalez on 11/3/18.
//  Copyright © 2018 Santiago Carmona Gonzalez. All rights reserved.
//

import UIKit
import SideMenu

class MenuTableViewCell: SideMenuTableViewCell {

    @IBOutlet weak var optionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func setCell(data: SideMenuOption) {
        optionLabel.text = data.title
    }
}
