//
//  ViewController.swift
//  WKWebViewExample
//
//  Created by Apple on 2019/3/9.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        getMaintenanceStatus { (isMaintenance) in
            if (isMaintenance) {
                
                self.getAnnouncementDescription(callback: { (description) in
                    if (description.count > 0) {
                        
                        let maintenanceVC = HtmlViewController()
                        maintenanceVC.mainInstance = self
                        maintenanceVC.urlType = 0
                        maintenanceVC.isMantanenceUrl = description
                        self.present(maintenanceVC, animated: true, completion: nil)
                        
                    } else {
                        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                        let nextVC = storyBoard.instantiateViewController(withIdentifier: "mainVC")
                        self.present(nextVC, animated: true, completion: nil)
                    }
                })
                
            } else {
                let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                let nextVC = storyBoard.instantiateViewController(withIdentifier: "mainVC")
                self.present(nextVC, animated: true, completion: nil)
            }
        }

    }
    
    
    func getMaintenanceStatus(callback: @escaping (_ isMaintenance:Bool) -> Void) {
        
        var headers:[String:String] = [String:String]()
        headers["Content-Type"] = "application/json"
        headers["X-LC-Id"] = "dewVBh3bQhLIgn5LIe6jkmyO-gzGzoHsz"
        headers["X-LC-Key"] = "R816QIH8ghrKRaTl4fUW3q0G"
        let maintenanceUrl = "https://leancloud.cn:443/1.1/classes/Maintenance?limit=1"
        downloadJasonDataAsDictionary(url: maintenanceUrl, type: "GET", headers: headers, uploadDic: nil) { (resultStatus, resultHeaders, resultDic, errorString) in
            
            if let mtArr = resultDic["results"] as? [Any] {
                if (mtArr.count > 0) {
                    if let mtDic = mtArr[0] as? [String:Any] {
                        if let mtBool = mtDic["Status"] as? Bool {
                            callback(mtBool)
                        } else {
                            callback(false)
                        }
                    } else {
                        callback(false)
                    }
                } else {
                    callback(false)
                }
            } else {
                callback(false)
            }
            
        }
        
    }

    func getAnnouncementDescription(callback: @escaping (_ Description:String) -> Void) {
        
        var headers:[String:String] = [String:String]()
        headers["Content-Type"] = "application/json"
        headers["X-LC-Id"] = "dewVBh3bQhLIgn5LIe6jkmyO-gzGzoHsz"
        headers["X-LC-Key"] = "R816QIH8ghrKRaTl4fUW3q0G"
        let maintenanceUrl = "https://leancloud.cn:443/1.1/classes/Announcement?limit=1"
        downloadJasonDataAsDictionary(url: maintenanceUrl, type: "GET", headers: headers, uploadDic: nil) { (resultStatus, resultHeaders, resultDic, errorString) in
            
            if let mtArr = resultDic["results"] as? [Any] {
                if (mtArr.count > 0) {
                    if let mtDic = mtArr[0] as? [String:Any] {
                        if let mtDesc = mtDic["Description"] as? String {
                            callback(mtDesc)
                        } else {
                            callback("")
                        }
                    } else {
                        callback("")
                    }
                } else {
                    callback("")
                }
            } else {
                callback("")
            }
            
        }
        
    }

}

