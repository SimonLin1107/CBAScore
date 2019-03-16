//
//  WebKitTeamViewController.swift
//  WKWebViewExample
//
//  Created by Apple on 2019/3/11.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit
import WebKit
import Kanna

class WebKitTeamViewController: UIViewController, WKNavigationDelegate {
    
    var webView:WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()

        webView = WKWebView()
        self.view.addSubview(webView)
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        webView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        webView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        webView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        
        webView.navigationDelegate = self
        
        let webUrl = "http://www.cba-chinaleague.com/team-logo.html"
        if let url:URL = URL(string: webUrl) {
            let request:URLRequest = URLRequest(url: url)
            webView.load(request)
        }
        
    }
    
    // 網頁加載完成
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        getWebViewData(webView)
        
    }
    
    func getWebViewData(_ webView: WKWebView) {
        
        webView.evaluateJavaScript("document.documentElement.outerHTML") { (any, error) in
            if let htString = any as? String {
                print("htString \(htString)")
                do {
                    let doc = try HTML(html: htString, encoding: String.Encoding.utf8)
                    let xpathObj = doc.xpath("//li[@data-club]")
                    if (xpathObj.count > 0) {
                        var teamArray:[ObjectTeam] = [ObjectTeam]()
                        for rate in xpathObj {
                            let teamObj = ObjectTeam()
                            if let teamId = rate["data-club"] {
                                print(teamId)
                                teamObj.teamId = teamId
                            }
                            let subDoc = try HTML(html: rate.innerHTML!, encoding: String.Encoding.utf8)
                            if let teamName = subDoc.xpath("//span")[0].text {
                                teamObj.teamName = teamName
                                print(teamName)
                            }
                            if let teamLogoUrl = subDoc.css("img")[0]["src"] {
                                teamObj.teamLogoUrl = teamLogoUrl
                                print(teamLogoUrl)
                            }
                            teamArray.append(teamObj)
                        }
                        self.getWebViewDataCompletedCallback(teamArray)
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
    
    func getWebViewDataCompletedCallback(_ teamArray: [ObjectTeam]) {
        
        print(teamArray[0].teamId + teamArray[0].teamName + teamArray[0].teamLogoUrl)
        
    }

}
