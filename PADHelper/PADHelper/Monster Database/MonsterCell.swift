//
//  MonsterCell.swift
//  PADHelper
//
//  Created by Rohil Thopu on 4/2/18.
//  Copyright © 2018 Rohil Thopu. All rights reserved.
//

import UIKit

class MonsterCell: UITableViewCell {

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var id: UILabel!
    @IBOutlet weak var rarity: UILabel!
    @IBOutlet weak var hp: UILabel!
    @IBOutlet weak var atk: UILabel!
    @IBOutlet weak var rcv: UILabel!
    
    var mnstr:Monster?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
