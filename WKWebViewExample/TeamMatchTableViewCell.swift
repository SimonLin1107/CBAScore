//
//  TeamTableViewCell.swift
//  WKWebViewExample
//
//  Created by Apple on 2019/3/11.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class TeamMatchTableViewCell: UITableViewCell {
    
    @IBOutlet weak var teamImageView: UIImageView!
    @IBOutlet weak var teamNameLabel: UILabel!
    @IBOutlet weak var teamSelectBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        teamImageView.image = nil
        teamNameLabel.text = ""
        teamSelectBtn.addTargetClosure { (sender) in
            
        }
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
