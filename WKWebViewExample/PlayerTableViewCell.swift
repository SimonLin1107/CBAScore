//
//  PlayerTableViewCell.swift
//  WKWebViewExample
//
//  Created by Apple on 2019/3/11.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class PlayerTableViewCell: UITableViewCell {
    
    @IBOutlet weak var playerNameLabel: UILabel!
    @IBOutlet weak var playerBirthLabel: UILabel!
    @IBOutlet weak var playerNumberLabel: UILabel!
    @IBOutlet weak var playerPositionLabel: UILabel!
    @IBOutlet weak var playerHeightLabel: UILabel!
    @IBOutlet weak var playerWeightLabel: UILabel!
    @IBOutlet weak var playerAgeLabel: UILabel!
    @IBOutlet weak var playerSelectBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        playerNameLabel.text = " "
        playerBirthLabel.text = " "
        playerNumberLabel.text = " "
        playerPositionLabel.text = " "
        playerHeightLabel.text = " "
        playerWeightLabel.text = " "
        playerAgeLabel.text = " "
        playerSelectBtn.addTargetClosure { (sender) in
            
        }

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
