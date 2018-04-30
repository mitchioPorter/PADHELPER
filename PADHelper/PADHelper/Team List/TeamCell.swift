//
//  TeamCell.swift
//  PADHelper
//
//  Created by Rohil Thopu on 4/10/18.
//  Copyright © 2018 Rohil Thopu. All rights reserved.
//

import UIKit

class TeamCell: UITableViewCell {

    @IBOutlet weak var m1: UIImageView!
    @IBOutlet weak var m2: UIImageView!
    @IBOutlet weak var m3: UIImageView!
    @IBOutlet weak var m4: UIImageView!
    @IBOutlet weak var m5: UIImageView!
    @IBOutlet weak var m6: UIImageView!

    @IBOutlet weak var teamname: UILabel!
        
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
