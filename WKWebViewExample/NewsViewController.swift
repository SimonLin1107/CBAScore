//
//  NewsViewController.swift
//  WKWebViewExample
//
//  Created by Apple on 2019/3/12.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit
import WebKit
import Kanna

class NewsViewController: UIViewController, WKNavigationDelegate {

    var mainInstance:MainViewController!
    @IBOutlet weak var wkWebView: WKWebView!
    @IBOutlet weak var newsTV: NewsTableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        wkWebView.navigationDelegate = self
        wkWebView.isHidden = true
        
        newsTV.dataSource = newsTV.self
        newsTV.delegate = newsTV.self
        newsTV.vcInstance = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let webUrl = "http://www.cba-chinaleague.com/zixun.html"
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
                    let xpathObj01 = doc.xpath("//a[@class='news01']")
                    let xpathObj02 = doc.xpath("//a[@class='news02']")
                    let xpathObj03 = doc.xpath("//a[@class='news03']")
                    let xpathObj = doc.xpath("//div[@class='moreload01']/ul/li")
                    if (xpathObj01.count > 0 && xpathObj02.count > 0 && xpathObj03.count > 0 && xpathObj.count > 0) {
                        
                        var newsArray:[ObjectNews] = [ObjectNews]()
                        
                        let newsTitle01 = xpathObj01[0].text!
                        var newsId01 = String(xpathObj01[0]["href"]![xpathObj01[0]["href"]!.lastIndex(of: "=")!...])
                        newsId01.removeFirst()
                        let doc01 = try HTML(html: xpathObj01[0].innerHTML!, encoding: String.Encoding.utf8)
                        let xpathObj01a = doc01.xpath("//p[@style]")
                        let removeLast01a = String(xpathObj01a[0]["style"]![..<xpathObj01a[0]["style"]!.lastIndex(of: ")")!])
                        var newsImageUrl01a = String(removeLast01a[xpathObj01a[0]["style"]!.firstIndex(of: "(")!...])
                        newsImageUrl01a.removeFirst()
                        
                        let newsObj01 = ObjectNews()
                        newsObj01.newsId = newsId01
                        newsObj01.newsTitle = newsTitle01
                        newsObj01.newsImageUrl = newsImageUrl01a
                        newsObj01.newsDate = "最新"
                        newsArray.append(newsObj01)
                        
                        var newsId02 = String(xpathObj02[0]["href"]![xpathObj02[0]["href"]!.lastIndex(of: "=")!...])
                        newsId02.removeFirst()
                        
                        let doc02 = try HTML(html: xpathObj02[0].innerHTML!, encoding: String.Encoding.utf8)
                        let newsTitle02 = doc02.xpath("//span/text()[1]")[0].text!
                        let newsDate02 = doc02.xpath("//span/text()[1]")[1].text!
                        
                        let xpathObj02a = doc02.xpath("//p[@style]")
                        let removeLast02a = String(xpathObj02a[0]["style"]![..<xpathObj02a[0]["style"]!.lastIndex(of: ")")!])
                        var newsImageUrl02a = String(removeLast02a[xpathObj02a[0]["style"]!.firstIndex(of: "(")!...])
                        newsImageUrl02a.removeFirst()
                        
                        let newsObj02 = ObjectNews()
                        newsObj02.newsId = newsId02
                        newsObj02.newsTitle = newsTitle02
                        newsObj02.newsImageUrl = newsImageUrl02a
                        newsObj02.newsDate = newsDate02
                        
                        newsArray.append(newsObj02)
                        
                        
                        var newsId03 = String(xpathObj03[0]["href"]![xpathObj03[0]["href"]!.lastIndex(of: "=")!...])
                        newsId03.removeFirst()
                        
                        let doc03 = try HTML(html: xpathObj03[0].innerHTML!, encoding: String.Encoding.utf8)
                        let newsTitle03 = doc03.xpath("//span/text()[1]")[0].text!
                        let newsDate03 = doc03.xpath("//span/text()[1]")[1].text!
                        
                        let xpathObj03a = doc03.xpath("//p[@style]")
                        let removeLast03a = String(xpathObj03a[0]["style"]![..<xpathObj03a[0]["style"]!.lastIndex(of: ")")!])
                        var newsImageUrl03a = String(removeLast03a[xpathObj03a[0]["style"]!.firstIndex(of: "(")!...])
                        newsImageUrl03a.removeFirst()
                        
                        let newsObj03 = ObjectNews()
                        newsObj03.newsId = newsId03
                        newsObj03.newsTitle = newsTitle03
                        newsObj03.newsImageUrl = newsImageUrl03a
                        newsObj03.newsDate = newsDate03
                        
                        newsArray.append(newsObj03)
                        
                        for rate in xpathObj {
                            let newsObj = ObjectNews()
                            if let newsId = rate["data-id"] {
                                newsObj.newsId = newsId
                            }
                            let subDoc = try HTML(html: rate.innerHTML!, encoding: String.Encoding.utf8)
                            
                            let newsTitle = subDoc.xpath("//span/text()[1]")[0].text!
                            let newsDate = subDoc.xpath("//span/text()[1]")[1].text!
                            
                            let xpathObjSub = subDoc.xpath("//p[@style]")
                            let removeLastSub = String(xpathObjSub[0]["style"]![..<xpathObjSub[0]["style"]!.lastIndex(of: ")")!])
                            var newsImageUrlSub = String(removeLastSub[xpathObjSub[0]["style"]!.firstIndex(of: "(")!...])
                            newsImageUrlSub.removeFirst()
                            
                            newsObj.newsTitle = newsTitle
                            newsObj.newsDate = newsDate
                            newsObj.newsImageUrl = newsImageUrlSub
                            
                            newsArray.append(newsObj)
                        }
                        
                        
                        self.getWebViewDataCompletedCallback(newsArray)
                        
                        
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
    
    func getWebViewDataCompletedCallback(_ newsArray: [ObjectNews]) {
        
        DispatchQueue.main.async {
            
            self.newsTV.newsArray = newsArray
            self.newsTV.reloadData()
            self.mainInstance.stopIndicator {
                
            }
            
        }
        
    }

}
