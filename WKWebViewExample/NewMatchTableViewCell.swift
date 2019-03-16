//
//  NewMatchTableViewCell.swift
//  WKWebViewExample
//
//  Created by Apple on 2019/3/12.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class NewMatchTableViewCell: UITableViewCell {

    @IBOutlet weak var homeTeamNameLabel: UILabel!
    @IBOutlet weak var guestTeamNameLabel: UILabel!
    @IBOutlet weak var homeTeamImageView: UIImageView!
    @IBOutlet weak var guestTeamImageView: UIImageView!
    @IBOutlet weak var matchStatusLabel: UILabel!
    @IBOutlet weak var matchDateLabel: UILabel!
    
    @IBOutlet weak var homeTeam1stScoreLabel: UILabel!
    @IBOutlet weak var guestTeam1stScoreLabel: UILabel!
    @IBOutlet weak var homeTeam2ndScoreLabel: UILabel!
    @IBOutlet weak var guestTeam2ndScoreLabel: UILabel!
    @IBOutlet weak var homeTeam3rdScoreLabel: UILabel!
    @IBOutlet weak var guestTeam3rdScoreLabel: UILabel!
    @IBOutlet weak var homeTeam4thScoreLabel: UILabel!
    @IBOutlet weak var guestTeam4thScoreLabel: UILabel!
    @IBOutlet weak var homeTeamTotalScoreLabel: UILabel!
    @IBOutlet weak var guestTeamTotalScoreLabel: UILabel!
    
    @IBOutlet weak var homeTeamMostScoreLabel: UILabel!
    @IBOutlet weak var guestTeamMostScoreLabel: UILabel!
    @IBOutlet weak var homeTeamMostReboundLabel: UILabel!
    @IBOutlet weak var guestTeamMostReboundLabel: UILabel!
    
    @IBOutlet weak var homeTeamMostAssistLabel: UILabel!
    @IBOutlet weak var guestTeamMostAssistLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
