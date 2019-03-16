//
//  PictureDetailTableView.swift
//  WKWebViewExample
//
//  Created by Apple on 2019/3/12.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class PictureDetailTableView: UITableView, UITableViewDelegate, UITableViewDataSource {

    var vcInstance:PictureDetailViewController!
    var pictureArray:[String] = [String]()
    var pictureHeight:[Int] = [Int]()
    var screenWidth:CGFloat = 0
    
    override func awakeFromNib() {
        screenWidth = UIScreen.main.bounds.size.width - 10 - 10
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictureArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pictureDetailTVC", for: indexPath) as! PictureDetailTableViewCell
        
        cell.pictureIndicator.isHidden = false
        cell.pictureIndicator.startAnimating()
        cell.pictureImageView.image = nil
        cell.tag = indexPath.row
        
        let urlString = self.pictureArray[indexPath.row].description
        
        downloadImage(url: urlString) { (image) in
            
            if (image != nil) {
                
                if (self.pictureHeight[indexPath.row] != Int(self.screenWidth * (image!.size.height/image!.size.width) + 3 + 3 - 15)) {
                    self.pictureHeight[indexPath.row] = Int(self.screenWidth * (image!.size.height/image!.size.width) + 3 + 3 - 15)
                    tableView.reloadData()
                }
                
                if (cell.tag == indexPath.row) {
                    cell.pictureImageView.image = image
                    cell.pictureIndicator.stopAnimating()
                    cell.pictureIndicator.isHidden = true
                }
                
            }
            
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(self.pictureHeight[indexPath.row])
    }

}
