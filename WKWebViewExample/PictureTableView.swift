//
//  PictureTableView.swift
//  WKWebViewExample
//
//  Created by Apple on 2019/3/12.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class PictureTableView: UITableView, UITableViewDelegate, UITableViewDataSource {

    var vcInstance:PictureViewController!
    var pictureArray:[ObjectPicture] = [ObjectPicture]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictureArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pictureTVC", for: indexPath) as! PictureTableViewCell
        
        cell.pictureImageView.image = nil
        cell.tag = indexPath.row
        downloadImage(url: pictureArray[indexPath.row].pictureImageUrl) { (image) in
            if (cell.tag == indexPath.row) {
                cell.pictureImageView.image = image
            }
        }
        
        cell.pictureTitleLabel.text = pictureArray[indexPath.row].pictureTitle
        cell.pictureSelectBtn.addTargetClosure { (sender) in
            
            self.vcInstance.mainInstance.currentPage.append(6)
            self.vcInstance.mainInstance.currentValue.append([self.pictureArray[indexPath.row].pictureId])
            
            self.vcInstance.mainInstance.setPictureDetailContent(galleryId: self.pictureArray[indexPath.row].pictureId, callback: {
                
            })
            
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

}
