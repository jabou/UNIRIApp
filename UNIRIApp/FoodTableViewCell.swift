//
//  FoodTableViewCell.swift
//  UNIRIApp
//
//  Created by Jasmin Abou Aldan on 19/07/15.
//  Copyright (c) 2015 Jasmin Abou Aldan. All rights reserved.
//

import UIKit

class FoodTableViewCell: UITableViewCell {

    @IBOutlet weak var objectTitle: UILabel!
    @IBOutlet weak var objectImage: UIImageView!
    @IBOutlet weak var objectAdress: UILabel!
    @IBOutlet weak var objectWorktime: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
