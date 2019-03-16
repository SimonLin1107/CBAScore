//
//  TeamGameTableViewCell.swift
//  WKWebViewExample
//
//  Created by Apple on 2019/3/14.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class TeamGameTableViewCell: UITableViewCell {

    @IBOutlet weak var turnLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var homeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var guestLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var selectBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        turnLabel.text = ""
        dateLabel.text = ""
        homeLabel.text = ""
        scoreLabel.text = ""
        guestLabel.text = ""
        resultLabel.text = ""
        selectBtn.addTargetClosure { (sender) in
            
        }
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
