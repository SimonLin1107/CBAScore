//
//  NewsTableView.swift
//  WKWebViewExample
//
//  Created by Apple on 2019/3/12.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class NewsTableView: UITableView, UITableViewDelegate, UITableViewDataSource {

    var vcInstance:NewsViewController!
    var newsArray:[ObjectNews] = [ObjectNews]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsTVC", for: indexPath) as! NewsTableViewCell
        
        cell.newsImageView.image = nil
        cell.tag = indexPath.row
        downloadImage(url: newsArray[indexPath.row].newsImageUrl) { (image) in
            if (cell.tag == indexPath.row) {
                cell.newsImageView.image = image
            }
        }
        
        cell.newsTitleLabel.text = newsArray[indexPath.row].newsDate
        cell.newsContentLabel.text = newsArray[indexPath.row].newsTitle
        cell.newsSelectBtn.addTargetClosure { (sender) in
            
            self.vcInstance.mainInstance.currentPage.append(5)
            self.vcInstance.mainInstance.currentValue.append(["http://www.cba-chinaleague.com/zxunxiangqing.html?id=" + self.newsArray[indexPath.row].newsId])
            
            self.vcInstance.mainInstance.setNewsDetailContent(url: "http://www.cba-chinaleague.com/zxunxiangqing.html?id=" + self.newsArray[indexPath.row].newsId, callback: {
                
            })
            
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

}
