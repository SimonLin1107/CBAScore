//
//  NewsTableViewCell.swift
//  WKWebViewExample
//
//  Created by Apple on 2019/3/12.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var newsTitleLabel: UILabel!
    @IBOutlet weak var newsContentLabel: UILabel!
    @IBOutlet weak var newsSelectBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        newsImageView.image = nil
        newsTitleLabel.text = ""
        newsContentLabel.text = ""
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
