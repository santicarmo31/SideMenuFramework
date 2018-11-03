//
//  SideMenuTableViewCell.swift
//  SideMenu
//
//  Created by Santiago Carmona Gonzalez on 5/20/18.
//  Copyright © 2018 Santiago Carmona Gonzalez. All rights reserved.
//

import UIKit

open class SideMenuTableViewCell: UITableViewCell {

    public static var identifier: String {
        return String(describing: self)
    }

    override open func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override open func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    open func setCell(data: SideMenuOption) {
        
    }

}
