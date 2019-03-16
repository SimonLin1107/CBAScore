//
//  PictureTableViewCell.swift
//  WKWebViewExample
//
//  Created by Apple on 2019/3/12.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class PictureTableViewCell: UITableViewCell {

    @IBOutlet weak var pictureImageView: UIImageView!
    @IBOutlet weak var pictureTitleLabel: UILabel!
    @IBOutlet weak var pictureSelectBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        pictureImageView.image = nil
        pictureTitleLabel.text = ""
        pictureSelectBtn.addTargetClosure { (sender) in
            
        }
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
