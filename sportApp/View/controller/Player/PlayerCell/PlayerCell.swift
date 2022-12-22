//
//  PlayerCell.swift
//  sportApp
//
//  Created by Celil Aydın on 22.12.2022.
//

import UIKit

class PlayerCell: UITableViewCell {

    @IBOutlet weak var imageVİew: UIImageView!
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var secondNameLabel: UILabel!
    
    static var identifier = "PlayerCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
