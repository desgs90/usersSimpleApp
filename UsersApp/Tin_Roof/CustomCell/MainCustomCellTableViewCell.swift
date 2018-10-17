//
//  MainCustomCellTableViewCell.swift
//  Tin_Roof
//
//  Created by Diego  on 10/17/18.
//  Copyright © 2018 Diego Santiago. All rights reserved.
//

import UIKit

class MainCustomCellTableViewCell: UITableViewCell {

	//MARK: - IBOUtlets
	@IBOutlet weak var cellTitle: UILabel!
	@IBOutlet weak var cellCounter: UILabel!
	
	
	override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
