//
//  AccomodationTableViewCell.swift
//  UNIRIApp
//
//  Created by Jasmin Abou Aldan on 26/11/2015.
//  Copyright (c) 2015 Jasmin Abou Aldan. All rights reserved.
//

import UIKit

class AccomodationTableViewCell: UITableViewCell {

    
    @IBOutlet weak var accomodationPicture: UIImageView!
    @IBOutlet weak var accomodationTitle: UILabel!
    @IBOutlet weak var accomodationAdress: UILabel!
    @IBOutlet weak var accomodationMaster: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
