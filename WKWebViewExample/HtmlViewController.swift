//
//  HtmlViewController.swift
//  WKWebViewExample
//
//  Created by Apple on 2019/3/12.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit
import WebKit
import Kanna

class HtmlViewController: UIViewController, WKNavigationDelegate {

    var mainInstance:UIViewController!
    var webView:WKWebView!
    var notMantanenceUrl:String = ""
    var urlType:Int = 0
    var isMantanenceUrl:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.layer.backgroundColor = UIColor.white.cgColor
        
        webView = WKWebView()
        self.view.addSubview(webView)
        webView.translatesAutoresizingMaskIntoConstraints = false
        
        var constraintsB = [NSLayoutConstraint]()
        constraintsB.append(NSLayoutConstraint(item: webView, attribute: .top, relatedBy: .equal, toItem: self.view.safeAreaLayoutGuide, attribute: .top, multiplier: 1.0, constant: 0))
        constraintsB.append(NSLayoutConstraint(item: webView, attribute: .left, relatedBy: .equal, toItem: self.view.safeAreaLayoutGuide, attribute: .left, multiplier: 1.0, constant: 0))
        constraintsB.append(NSLayoutConstraint(item: webView, attribute: .right, relatedBy: .equal, toItem: self.view.safeAreaLayoutGuide, attribute: .right, multiplier: 1.0, constant: 0))
        constraintsB.append(NSLayoutConstraint(item: webView, attribute: .bottom, relatedBy: .equal, toItem: self.view.safeAreaLayoutGuide, attribute: .bottom, multiplier: 1.0, constant: 0))
        self.view.addConstraints(constraintsB)
        
        webView.navigationDelegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        webView.isHidden = true
        if let url:URL = URL(string: isMantanenceUrl) {
            let request:URLRequest = URLRequest(url: url)
            
            self.webView.load(request)
            
        } else {
            if let url:URL = URL(string: notMantanenceUrl) {
                let request:URLRequest = URLRequest(url: url)
                
                if let mainIns = mainInstance as? MainViewController {
                    mainIns.startIndicator {
                        self.webView.load(request)
                    }
                }
                
            } else {
                self.dismiss(animated: true, completion: nil)
            }
        }
        
    }
    
    // 網頁加載完成
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        if (urlType == 1) {
            getWebViewData(webView)
        } else {
            webView.isHidden = false
        }
    }
    
    func getWebViewData(_ webView: WKWebView) {
        
        webView.evaluateJavaScript("document.documentElement.outerHTML") { (any, error) in
            if let htString = any as? String {
                
                
                do {
                    let doc = try HTML(html: htString, encoding: String.Encoding.utf8)
                    let xpathObjTitle = doc.xpath("//div[@class='newstitle']")
                    let xpathObjDate = doc.xpath("//div[@class='source']/span/text()[1]")
                    let xpathObjContent = doc.xpath("//div[@class='newstxt']/p[@style]")
                    if (xpathObjTitle.count > 0 && xpathObjDate.count > 0 && xpathObjContent.count > 0) {
                        
                        var result = "<div style='text-align: center;text-indent: 0em;'><h1>" + xpathObjTitle[0].text! + "</h1></div>"
                        result = result + "<div style='text-align: right;text-indent: 2em;'><h2>" + xpathObjDate[0].text! + "</h2></div>"
                        result = result + "<div><h2>"
                        for content in xpathObjContent {
                            if let str = content.text {
                                if (str.count > 0) {
                                    result = result + "<p style='text-align: left;text-indent: 2em;'>" + str + "</p>"
                                }
                            }
                        }
                        result = result + "</h2></div>"
                        self.getNewsWebViewDataCompletedCallback(result)
                        
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
    
    func getNewsWebViewDataCompletedCallback(_ htmlString: String) {
        
        DispatchQueue.main.async {
            
            self.urlType = 0
            self.webView.loadHTMLString(htmlString, baseURL: nil)
            if let mainIns = self.mainInstance as? MainViewController {
                mainIns.stopIndicator {
                    self.webView.isHidden = false
                }
            }
            
        }
        
    }

}
