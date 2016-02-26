//
//  CustomTableViewCell.swift
//  UNIRIApp
//
//  Created by Jasmin Abou Aldan on 08/11/2015.
//  Copyright (c) 2015 Jasmin Abou Aldan. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellPicture: UIImageView!
    @IBOutlet weak var cellLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
