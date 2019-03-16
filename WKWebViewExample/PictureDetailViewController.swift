//
//  PictureDetailViewController.swift
//  WKWebViewExample
//
//  Created by Apple on 2019/3/12.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit
import WebKit
import Kanna

class PictureDetailViewController: UIViewController, WKNavigationDelegate {
    
    var mainInstance:MainViewController!
    @IBOutlet weak var wkWebView: WKWebView!
    @IBOutlet weak var pictureDetailTV: PictureDetailTableView!
    var galleryId = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        wkWebView.navigationDelegate = self
        wkWebView.isHidden = true
        
        pictureDetailTV.dataSource = pictureDetailTV.self
        pictureDetailTV.delegate = pictureDetailTV.self
        pictureDetailTV.vcInstance = self
        
        pictureDetailTV.tableFooterView = UIView()
        
    }
    

    override func viewWillAppear(_ animated: Bool) {
        
        if let url:URL = URL(string: "http://www.cba-chinaleague.com/pic_details.html?id="+galleryId) {
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
                
                print(htString)
                do {
                    let doc = try HTML(html: htString, encoding: String.Encoding.utf8)
                    
                    let xpathObjTemp = doc.xpath("//section[@class='section_list']")
                    if (xpathObjTemp.count > 0) {
                        let docTemp = try HTML(html: xpathObjTemp[0].innerHTML!, encoding: String.Encoding.utf8)
                        let xpathObj = docTemp.xpath("//div[@id='img']")
                        if (xpathObj.count > 0) {
                            
                            let doc1st = try HTML(html: xpathObj[0].innerHTML!, encoding: String.Encoding.utf8)
                            let xpathObj1st = doc1st.xpath("//p")
                            
                            if (xpathObj1st.count > 0) {
                                
                                var pictureArray:[String] = [String]()
                                
                                for rate in xpathObj1st {
                                    
                                    let srcString = rate["style"]!
                                    let removeLastSub = String(srcString[..<srcString.lastIndex(of: ")")!])
                                    var newsImageUrlSub = String(removeLastSub[srcString.firstIndex(of: "(")!...])
                                    newsImageUrlSub.removeFirst()
                                    
                                    if (newsImageUrlSub.first == "\"") {
                                        newsImageUrlSub.removeFirst()
                                        newsImageUrlSub.removeLast()
                                    }
                                    
                                    pictureArray.append(newsImageUrlSub)
                                    
                                }
                                
                                self.getWebViewDataCompletedCallback(pictureArray)
                                
                            } else {
                                self.getWebViewData(webView)
                            }
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
    
    func getWebViewDataCompletedCallback(_ pictureArray: [String]) {
        
        var pictureHeight:[Int] = [Int]()
        let screenWidth = UIScreen.main.bounds.size.width - 10 - 10
        for _ in pictureArray {
            pictureHeight.append(Int(screenWidth*3.0/4.0 + 3 + 3))
        }
        DispatchQueue.main.async {
            
            self.pictureDetailTV.pictureArray = pictureArray
            self.pictureDetailTV.pictureHeight = pictureHeight
            self.pictureDetailTV.reloadData()
            self.mainInstance.stopIndicator {
                
            }
            
        }
        
    }

}
