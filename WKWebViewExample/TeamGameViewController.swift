//
//  TeamGameViewController.swift
//  WKWebViewExample
//
//  Created by Apple on 2019/3/14.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit
import WebKit
import Kanna

class TeamGameViewController: UIViewController, WKNavigationDelegate {

    var mainInstance:MainViewController!
    @IBOutlet weak var wkWebView: WKWebView!
    @IBOutlet weak var teamGameTV: TeamGameTableView!
    var teamId:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        wkWebView.navigationDelegate = self
        wkWebView.isHidden = true
        
        teamGameTV.dataSource = teamGameTV.self
        teamGameTV.delegate = teamGameTV.self
        teamGameTV.vcInstance = self
        
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
                    let xpathObj = doc.xpath("//ul[@class='lie011']")
                    if (xpathObj.count > 0) {
                        let subDoc = try HTML(html: xpathObj[0].innerHTML!, encoding: String.Encoding.utf8)
                        let xpathSubObj = subDoc.xpath("//li")
                        if (xpathSubObj.count > 0) {
                            
                            var gameArray:[ObjectGame] = [ObjectGame]()
                            for rate in xpathSubObj {
                                let gameObj = ObjectGame()
                                let lastDoc = try HTML(html: rate.innerHTML!, encoding: String.Encoding.utf8)
                                let xpathLastObj = lastDoc.xpath("//span")
                                if let gameDate = xpathLastObj[0].text {
                                    gameObj.gameDate = gameDate
                                }
                                if let gameTurn = xpathLastObj[3].text {
                                    gameObj.gameTurn = gameTurn
                                }
                                if let gameHomeTeam = xpathLastObj[4].text {
                                    gameObj.gameHomeTeam = gameHomeTeam
                                }
                                if let gameScore = xpathLastObj[5].text {
                                    gameObj.gameScore = gameScore
                                }
                                if let gameGuestTeam = xpathLastObj[6].text {
                                    gameObj.gameGuestTeam = gameGuestTeam
                                }
                                if let gameResult = xpathLastObj[7].text {
                                    gameObj.gameResult = gameResult
                                }
                                
                                gameArray.append(gameObj)
                            }
                            
                            self.getWebViewDataCompletedCallback(gameArray)
                            
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
    
    func getWebViewDataCompletedCallback(_ gameArray: [ObjectGame]) {
        
        DispatchQueue.main.async {
            self.teamGameTV.gameArray = gameArray
            self.teamGameTV.reloadData()
            self.mainInstance.stopIndicator {
                
            }
        }
        
    }

}
