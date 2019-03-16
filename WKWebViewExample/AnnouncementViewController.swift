//
//  AnnouncementViewController.swift
//  WKWebViewExample
//
//  Created by Apple on 2019/3/11.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit
import WebKit

class AnnouncementViewController: UIViewController, WKNavigationDelegate {

    var contentView:WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()

        contentView = WKWebView()
        self.view.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        contentView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        contentView.navigationDelegate = self
        let webUrl = "http://www.cba-chinaleague.com/team-logo.html"
        if let url:URL = URL(string: webUrl) {
            let request:URLRequest = URLRequest(url: url)
            contentView.load(request)
        }
    }
    
    // 網頁加載完成
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        webView.evaluateJavaScript("document.documentElement.outerHTML") { (any, error) in
            if let htString = any as? String {
                print("htString \(htString)")
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
