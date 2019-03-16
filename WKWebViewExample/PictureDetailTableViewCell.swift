//
//  PictureDetailTableViewCell.swift
//  WKWebViewExample
//
//  Created by Apple on 2019/3/12.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class PictureDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var pictureIndicator: UIActivityIndicatorView!
    @IBOutlet weak var pictureImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        pictureIndicator.stopAnimating()
        pictureIndicator.isHidden = true
        pictureImageView.image = nil
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
