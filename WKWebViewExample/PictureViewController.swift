//
//  PictureViewController.swift
//  WKWebViewExample
//
//  Created by Apple on 2019/3/12.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit
import WebKit
import Kanna

class PictureViewController: UIViewController, WKNavigationDelegate {
    
    var mainInstance:MainViewController!
    @IBOutlet weak var wkWebView: WKWebView!
    @IBOutlet weak var pictureTV: PictureTableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let webConfiguration = WKWebViewConfiguration()
        print(webConfiguration.preferences.minimumFontSize)
        wkWebView.navigationDelegate = self
        wkWebView.isHidden = true
        
        pictureTV.dataSource = pictureTV.self
        pictureTV.delegate = pictureTV.self
        pictureTV.vcInstance = self
        
    }
    

    override func viewWillAppear(_ animated: Bool) {
        let webUrl = "http://www.cba-chinaleague.com/pic_list.html"
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
                    
                    let xpathObj01 = doc.xpath("//div[@class='pic_listB pic_same opacity']")
                    let xpathObj02 = doc.xpath("//div[@class='pic_list1 pic_same opacity']")
                    if (xpathObj01.count > 0 && xpathObj02.count > 0) {
                        var pictureArray:[ObjectPicture] = [ObjectPicture]()
                        
                        let id1st = xpathObj01[0]["data-id"]!
                        let doc1st = try HTML(html: xpathObj01[0].innerHTML!, encoding: String.Encoding.utf8)
                        let title1st = doc1st.xpath("//p[@class='pic_listb_p1']")[0].text!
                        let image1st = doc1st.xpath("//img[@src]")[0]["src"]!
                        
                        let pictureObj1st = ObjectPicture()
                        pictureObj1st.pictureId = id1st
                        pictureObj1st.pictureImageUrl = image1st
                        pictureObj1st.pictureTitle = title1st
                        
                        pictureArray.append(pictureObj1st)
                        
                        for rate in xpathObj02 {
                            
                            let idSub = rate["data-id"]!
                            let docSub = try HTML(html: rate.innerHTML!, encoding: String.Encoding.utf8)
                            let titleSub = docSub.xpath("//p[@class='pic_list1_p1']")[0].text!
                            let imageSub = docSub.xpath("//img[@src]")[0]["src"]!
                            
                            let pictureObjSub = ObjectPicture()
                            pictureObjSub.pictureId = idSub
                            pictureObjSub.pictureImageUrl = imageSub
                            pictureObjSub.pictureTitle = titleSub
                            
                            pictureArray.append(pictureObjSub)
                            
                        }
                        
                        self.getWebViewDataCompletedCallback(pictureArray)
                        
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
    
    func getWebViewDataCompletedCallback(_ pictureArray: [ObjectPicture]) {
        
        DispatchQueue.main.async {
            
            self.pictureTV.pictureArray = pictureArray
            self.pictureTV.reloadData()
            self.mainInstance.stopIndicator {
                
            }
            
        }
        
    }

}
