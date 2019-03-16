//
//  PlayerViewController.swift
//  WKWebViewExample
//
//  Created by Apple on 2019/3/11.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit
import WebKit
import Kanna

class PlayerViewController: UIViewController, WKNavigationDelegate {

    var mainInstance:MainViewController!
    @IBOutlet weak var wkWebView: WKWebView!
    @IBOutlet weak var playerTV: PlayerTableView!
    var teamId:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        wkWebView.navigationDelegate = self
        wkWebView.isHidden = true
        
        playerTV.dataSource = playerTV.self
        playerTV.delegate = playerTV.self
        playerTV.vcInstance = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let webUrl = "http://www.cba-chinaleague.com/team.html?id="+self.teamId
        print(webUrl)
        if let url:URL = URL(string: webUrl) {
            let request:URLRequest = URLRequest(url: url)
            
            self.mainInstance.startIndicator {
                self.wkWebView.load(request)
            }
            
        }
    }

    // 網頁加載完成
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        getWebViewData(webView)
        
    }
    
    func getWebViewData(_ webView: WKWebView) {
        
        webView.evaluateJavaScript("document.documentElement.outerHTML") { (any, error) in
            if let htString = any as? String {
                
                do {
                    let doc = try HTML(html: htString, encoding: String.Encoding.utf8)
//                    let xpathObj = doc.xpath("//div[@class='member_list']")
                    let xpathObj = doc.xpath("//ul[@class='lie01']")
                    if (xpathObj.count > 0) {
                        let subDoc = try HTML(html: xpathObj[0].innerHTML!, encoding: String.Encoding.utf8)
                        let xpathSubObj = subDoc.xpath("//li")
                        if (xpathSubObj.count > 0) {
                            
                            var playerArray:[ObjectPlayer] = [ObjectPlayer]()
                            for rate in xpathSubObj {
                                let playerObj = ObjectPlayer()
                                let lastDoc = try HTML(html: rate.innerHTML!, encoding: String.Encoding.utf8)
                                let xpathLastObj = lastDoc.xpath("//span")
                                if let playerId = xpathLastObj[0].text {
                                    playerObj.playerNumber = playerId
                                }
                                if let playerId = xpathLastObj[1]["data-id"] {
                                    playerObj.playerId = playerId
                                }
                                if let playerName = xpathLastObj[1].text {
                                    playerObj.playerName = playerName
                                }
                                if let playerPosition = xpathLastObj[2].text {
                                    playerObj.playerPosition = playerPosition
                                }
                                if let playerHeight = xpathLastObj[3].text {
                                    playerObj.playerHeight = playerHeight
                                }
                                if let playerWeight = xpathLastObj[4].text {
                                    playerObj.playerWeight = playerWeight
                                }
                                if let playerAge = xpathLastObj[5].text {
                                    playerObj.playerAge = playerAge
                                }
                                if let playerBirth = xpathLastObj[6].text {
                                    playerObj.playerBirth = playerBirth
                                }
                                playerArray.append(playerObj)
                            }
                            
                            self.getWebViewDataCompletedCallback(playerArray)
                            
                        } else {
                            self.getWebViewData(webView)
                        }
                    } else {
                        self.getWebViewData(webView)
                    }
                } catch let err {
                    print("\(err)")
                }
                
            }
            
            if let err = error {
                print("\(err)")
            }
        }
        
    }
    
    func getWebViewDataCompletedCallback(_ playerArray: [ObjectPlayer]) {
        
        DispatchQueue.main.async {
            self.playerTV.playerArray = playerArray
            self.playerTV.reloadData()
            self.mainInstance.stopIndicator {
                
            }
        }
        
    }

}
