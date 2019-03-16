//
//  PlayerDetailViewController.swift
//  WKWebViewExample
//
//  Created by Apple on 2019/3/14.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit
import WebKit
import Kanna

class PlayerDetailViewController: UIViewController, WKNavigationDelegate {

    var mainInstance:MainViewController!
    var playerId:String = ""
    @IBOutlet weak var wkWebView: WKWebView!
    
    @IBOutlet weak var playerImageView: UIImageView!
    @IBOutlet weak var playerNameLabel: UILabel!
    @IBOutlet weak var playerNumberLabel: UILabel!
    @IBOutlet weak var playerPositionLabel: UILabel!
    @IBOutlet weak var playerHeightLabel: UILabel!
    @IBOutlet weak var playerWeightLabel: UILabel!
    @IBOutlet weak var playerAgeLabel: UILabel!
    
    @IBOutlet weak var a1Label: UIButton!
    @IBOutlet weak var a2Label: UIButton!
    @IBOutlet weak var a3Label: UIButton!
    @IBOutlet weak var a4Label: UIButton!
    @IBOutlet weak var a5Label: UIButton!
    @IBOutlet weak var a6Label: UIButton!
    @IBOutlet weak var a7Label: UIButton!
    
    @IBOutlet weak var b1Label: UIButton!
    @IBOutlet weak var b2Label: UIButton!
    @IBOutlet weak var b3Label: UIButton!
    @IBOutlet weak var b4Label: UIButton!
    @IBOutlet weak var b5Label: UIButton!
    @IBOutlet weak var b6Label: UIButton!
    @IBOutlet weak var b7Label: UIButton!
    
    @IBOutlet weak var t1Label: UIButton!
    @IBOutlet weak var t2Label: UIButton!
    @IBOutlet weak var t3Label: UIButton!
    @IBOutlet weak var t4Label: UIButton!
    @IBOutlet weak var t5Label: UIButton!
    @IBOutlet weak var t6Label: UIButton!
    @IBOutlet weak var t7Label: UIButton!
    
    @IBOutlet weak var c1Label: UIButton!
    @IBOutlet weak var c2Label: UIButton!
    @IBOutlet weak var c3Label: UIButton!
    @IBOutlet weak var c4Label: UIButton!
    @IBOutlet weak var c5Label: UIButton!
    @IBOutlet weak var c6Label: UIButton!
    @IBOutlet weak var c7Label: UIButton!
    
    @IBOutlet weak var d1Label: UIButton!
    @IBOutlet weak var d2Label: UIButton!
    @IBOutlet weak var d3Label: UIButton!
    @IBOutlet weak var d4Label: UIButton!
    @IBOutlet weak var d5Label: UIButton!
    @IBOutlet weak var d6Label: UIButton!
    @IBOutlet weak var d7Label: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        wkWebView.navigationDelegate = self
        wkWebView.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let webUrl = "http://www.cbaleague.com/players.html?id="+self.playerId
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
                    
                    let xpathObj01 = doc.xpath("//div[@class='contain fltt']/div[@class='con1000']/div[@class='player-top']")
                    let subDoc01 = try HTML(html: xpathObj01[0].innerHTML!, encoding: String.Encoding.utf8)
                    let playerImageUrl = subDoc01.xpath("//img[@class='player_img']")[0]["src"]
                    let playerInfoString = subDoc01.xpath("//div[@class='pl-data']")[0].text!
                    
                    let playerNumberString = subDoc01.xpath("//div[@class='bigname']/span")[0].text!
                    let playerNameString = subDoc01.xpath("//div[@class='bigname']/span")[1].text!
                    
                    let xpathObj02temp = doc.xpath("//div[@class='contain fltt']/div[@class='con1000']/div[@class='pl-datacon']/ul[@class='lie022']/p")
                    let xpathObj02 = doc.xpath("//div[@class='contain fltt']/div[@class='con1000']/div[@class='pl-datacon']/ul[@class='lie022']/li[@class='bsj_tj']/span")
                    
                    let xpathObj03temp = doc.xpath("//div[@class='contain fltt']/div[@class='con1000']/div[@class='career']/ul[@class='lie034']/p")
                    let xpathObj03 = doc.xpath("//div[@class='contain fltt']/div[@class='con1000']/div[@class='career']/ul[@class='lie034']/li")
                    
                    if ((xpathObj02temp.count > 0 || xpathObj02.count > 0) && (xpathObj03temp.count > 0 || xpathObj03.count > 1)) {
                        
                        self.playerNameLabel.text = playerNameString
                        self.playerNumberLabel.text = "号码：" + playerNumberString
                        
                        if (playerImageUrl != nil) {
                            if (playerImageUrl!.count > 0) {
                                downloadImage(url: playerImageUrl!) { (image) in
                                    self.playerImageView.image = image
                                }
                            }
                        }
                        
                        var playerPosition = String(playerInfoString[..<playerInfoString.firstIndex(of: "｜")!])
                        playerPosition = String(playerPosition[playerPosition.firstIndex(of: "：")!...])
                        playerPosition.removeFirst()
                        
                        self.playerPositionLabel.text = "位置：" + playerPosition
                        
                        var subInfoString = String(playerInfoString[playerInfoString.firstIndex(of: "｜")!...])
                        subInfoString.removeFirst()
                        
                        var playerHeight = String(subInfoString[..<subInfoString.firstIndex(of: "｜")!])
                        playerHeight = String(playerHeight[playerHeight.firstIndex(of: "：")!...])
                        playerHeight.removeFirst()
                        
                        self.playerHeightLabel.text = "身高：" + playerHeight
                        
                        var thirdInfoString = String(subInfoString[subInfoString.firstIndex(of: "｜")!...])
                        thirdInfoString.removeFirst()
                        
                        var playerWeight = String(thirdInfoString[..<thirdInfoString.firstIndex(of: "｜")!])
                        playerWeight = String(playerWeight[playerWeight.firstIndex(of: "：")!...])
                        playerWeight.removeFirst()
                        
                        self.playerWeightLabel.text = "体重：" + playerWeight
                        
                        var fourthInfoString = String(thirdInfoString[thirdInfoString.firstIndex(of: "｜")!...])
                        fourthInfoString.removeFirst()
                        
                        var playerAge = String(fourthInfoString[fourthInfoString.firstIndex(of: "：")!...])
                        playerAge.removeFirst()
                        
                        self.playerAgeLabel.text = "年龄：" + playerAge
                        
                        if (xpathObj02.count > 0) {
                            self.a1Label.setTitle(xpathObj02[0].text!, for: UIControl.State.normal)
                            self.a2Label.setTitle(xpathObj02[1].text!, for: UIControl.State.normal)
                            self.a3Label.setTitle(xpathObj02[2].text!, for: UIControl.State.normal)
                            self.a4Label.setTitle(xpathObj02[3].text!, for: UIControl.State.normal)
                            self.a5Label.setTitle(xpathObj02[4].text!, for: UIControl.State.normal)
                            
                            let removeLast = String(xpathObj02[5].text![..<xpathObj02[5].text!.lastIndex(of: ")")!])
                            var removeFirst = String(removeLast[xpathObj02[5].text!.firstIndex(of: "(")!...])
                            removeFirst.removeFirst()
                            
                            let firstRebound = String(removeFirst[..<removeFirst.lastIndex(of: "/")!])
                            
                            var secoundRebound = String(removeFirst[removeFirst.firstIndex(of: "/")!...])
                            secoundRebound.removeFirst()
                            
                            self.a6Label.setTitle(firstRebound, for: UIControl.State.normal)
                            self.a7Label.setTitle(secoundRebound, for: UIControl.State.normal)
                            self.b1Label.setTitle(xpathObj02[6].text!, for: UIControl.State.normal)
                            self.b2Label.setTitle(xpathObj02[7].text!, for: UIControl.State.normal)
                            self.b3Label.setTitle(xpathObj02[8].text!, for: UIControl.State.normal)
                            self.b4Label.setTitle(xpathObj02[9].text!, for: UIControl.State.normal)
                            self.b5Label.setTitle(xpathObj02[10].text!, for: UIControl.State.normal)
                            self.b6Label.setTitle(xpathObj02[11].text!, for: UIControl.State.normal)
                            self.b7Label.setTitle(xpathObj02[12].text!, for: UIControl.State.normal)
                        } else {
                            self.a1Label.setTitle("无", for: UIControl.State.normal)
                            self.a2Label.setTitle("无", for: UIControl.State.normal)
                            self.a3Label.setTitle("无", for: UIControl.State.normal)
                            self.a4Label.setTitle("无", for: UIControl.State.normal)
                            self.a5Label.setTitle("无", for: UIControl.State.normal)
                            self.a6Label.setTitle("无", for: UIControl.State.normal)
                            self.a7Label.setTitle("无", for: UIControl.State.normal)
                            self.b1Label.setTitle("无", for: UIControl.State.normal)
                            self.b2Label.setTitle("无", for: UIControl.State.normal)
                            self.b3Label.setTitle("无", for: UIControl.State.normal)
                            self.b4Label.setTitle("无", for: UIControl.State.normal)
                            self.b5Label.setTitle("无", for: UIControl.State.normal)
                            self.b6Label.setTitle("无", for: UIControl.State.normal)
                            self.b7Label.setTitle("无", for: UIControl.State.normal)
                        }
                        
                        if (xpathObj03.count > 1) {
                            var title1 = "单场得分最多"
                            var title2 = "单场篮板最多"
                            var title3 = "单场三分最多"
                            var title4 = "单场助攻最多"
                            var title5 = "单场盖帽最多"
                            var title6 = "单场扣篮最多"
                            var title7 = "单场抢断最多"
                            var point1 = "无"
                            var point2 = "无"
                            var point3 = "无"
                            var point4 = "无"
                            var point5 = "无"
                            var point6 = "无"
                            var point7 = "无"
                            var position1 = "无"
                            var position2 = "无"
                            var position3 = "无"
                            var position4 = "无"
                            var position5 = "无"
                            var position6 = "无"
                            var position7 = "无"
                        
                            for i in 1..<xpathObj03.count {
                                let loopDoc = try HTML(html: xpathObj03[i].innerHTML!, encoding: String.Encoding.utf8)
                                let xpathObjLoop = loopDoc.xpath("//span")
                                if (xpathObjLoop[0].text! == "单场得分最多") {
                                    
                                    if (point1 != "无") {
                                        title1 = title1 + "\n "
                                        point1 = point1 + "\n "
                                        position1 = position1 + "\n" + xpathObjLoop[2].text!
                                    } else {
                                        point1 = xpathObjLoop[1].text!
                                        position1 = xpathObjLoop[2].text!
                                    }
                                    
                                } else if (xpathObjLoop[0].text! == "单场篮板最多") {
                                    
                                    if (point2 != "无") {
                                        title2 = title2 + "\n "
                                        point2 = point2 + "\n "
                                        position2 = position2 + "\n" + xpathObjLoop[2].text!
                                    } else {
                                        point2 = xpathObjLoop[1].text!
                                        position2 = xpathObjLoop[2].text!
                                    }
                                    
                                } else if (xpathObjLoop[0].text! == "单场三分最多") {
                                    
                                    if (point3 != "无") {
                                        title3 = title3 + "\n "
                                        point3 = point3 + "\n "
                                        position3 = position3 + "\n" + xpathObjLoop[2].text!
                                    } else {
                                        point3 = xpathObjLoop[1].text!
                                        position3 = xpathObjLoop[2].text!
                                    }
                                    
                                } else if (xpathObjLoop[0].text! == "单场助攻最多") {
                                    
                                    if (point4 != "无") {
                                        title4 = title4 + "\n "
                                        point4 = point4 + "\n "
                                        position4 = position4 + "\n" + xpathObjLoop[2].text!
                                    } else {
                                        point4 = xpathObjLoop[1].text!
                                        position4 = xpathObjLoop[2].text!
                                    }
                                    
                                } else if (xpathObjLoop[0].text! == "单场盖帽最多") {
                                    
                                    if (point5 != "无") {
                                        title5 = title5 + "\n "
                                        point5 = point5 + "\n "
                                        position5 = position5 + "\n" + xpathObjLoop[2].text!
                                    } else {
                                        point5 = xpathObjLoop[1].text!
                                        position5 = xpathObjLoop[2].text!
                                    }
                                    
                                } else if (xpathObjLoop[0].text! == "单场扣篮最多") {
                                    
                                    if (point6 != "无") {
                                        title6 = title6 + "\n "
                                        point6 = point6 + "\n "
                                        position6 = position6 + "\n" + xpathObjLoop[2].text!
                                    } else {
                                        point6 = xpathObjLoop[1].text!
                                        position6 = xpathObjLoop[2].text!
                                    }
                                    
                                } else if (xpathObjLoop[0].text! == "单场抢断最多") {
                                    
                                    if (point7 != "无") {
                                        title7 = title7 + "\n "
                                        point7 = point7 + "\n "
                                        position7 = position7 + "\n" + xpathObjLoop[2].text!
                                    } else {
                                        point7 = xpathObjLoop[1].text!
                                        position7 = xpathObjLoop[2].text!
                                    }
                                    
                                }
                            }
                            
                            self.t1Label.setTitle(title1, for: UIControl.State.normal)
                            self.c1Label.setTitle(point1, for: UIControl.State.normal)
                            self.d1Label.setTitle(position1, for: UIControl.State.normal)
                            self.t2Label.setTitle(title2, for: UIControl.State.normal)
                            self.c2Label.setTitle(point2, for: UIControl.State.normal)
                            self.d2Label.setTitle(position2, for: UIControl.State.normal)
                            self.t3Label.setTitle(title3, for: UIControl.State.normal)
                            self.c3Label.setTitle(point3, for: UIControl.State.normal)
                            self.d3Label.setTitle(position3, for: UIControl.State.normal)
                            self.t4Label.setTitle(title4, for: UIControl.State.normal)
                            self.c4Label.setTitle(point4, for: UIControl.State.normal)
                            self.d4Label.setTitle(position4, for: UIControl.State.normal)
                            self.t5Label.setTitle(title5, for: UIControl.State.normal)
                            self.c5Label.setTitle(point5, for: UIControl.State.normal)
                            self.d5Label.setTitle(position5, for: UIControl.State.normal)
                            self.t6Label.setTitle(title6, for: UIControl.State.normal)
                            self.c6Label.setTitle(point6, for: UIControl.State.normal)
                            self.d6Label.setTitle(position6, for: UIControl.State.normal)
                            self.t7Label.setTitle(title7, for: UIControl.State.normal)
                            self.c7Label.setTitle(point7, for: UIControl.State.normal)
                            self.d7Label.setTitle(position7, for: UIControl.State.normal)
                                
                        } else {
                            self.c1Label.setTitle("无", for: UIControl.State.normal)
                            self.c2Label.setTitle("无", for: UIControl.State.normal)
                            self.c3Label.setTitle("无", for: UIControl.State.normal)
                            self.c4Label.setTitle("无", for: UIControl.State.normal)
                            self.c5Label.setTitle("无", for: UIControl.State.normal)
                            self.c6Label.setTitle("无", for: UIControl.State.normal)
                            self.c7Label.setTitle("无", for: UIControl.State.normal)
                            self.d1Label.setTitle("无", for: UIControl.State.normal)
                            self.d2Label.setTitle("无", for: UIControl.State.normal)
                            self.d3Label.setTitle("无", for: UIControl.State.normal)
                            self.d4Label.setTitle("无", for: UIControl.State.normal)
                            self.d5Label.setTitle("无", for: UIControl.State.normal)
                            self.d6Label.setTitle("无", for: UIControl.State.normal)
                            self.d7Label.setTitle("无", for: UIControl.State.normal)
                        }
                        
                        DispatchQueue.main.async {
                            self.mainInstance.stopIndicator {
                                
                            }
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

}
