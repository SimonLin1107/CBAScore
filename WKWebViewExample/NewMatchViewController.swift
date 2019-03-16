//
//  NewMatchViewController.swift
//  WKWebViewExample
//
//  Created by Apple on 2019/3/12.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit
import WebKit
import Kanna

class NewMatchViewController: UIViewController, WKNavigationDelegate {

    var mainInstance:MainViewController!
    @IBOutlet weak var wkWebView: WKWebView!
    @IBOutlet weak var newMatchTV: NewMatchTableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        wkWebView.navigationDelegate = self
        wkWebView.isHidden = true
        
        newMatchTV.dataSource = newMatchTV.self
        newMatchTV.delegate = newMatchTV.self
        newMatchTV.vcInstance = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        let webUrl = "http://www.cba-chinaleague.com/regularseason.html"
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
                    let xpathObj = doc.xpath("//ul[@class='lun-match']")
                    if (xpathObj.count > 0) {
                        
                        let docB = try HTML(html: xpathObj[0].innerHTML!, encoding: String.Encoding.utf8)
                        let xpathObjB = docB.xpath("//li[@data-id]")
                        if (xpathObjB.count > 0) {
                            
                            var matchArray:[ObjectMatch] = [ObjectMatch]()
                            for rateB in xpathObjB {
                                let matchObj = ObjectMatch()
                                if let matchId = rateB["data-id"] {
                                    matchObj.matchId = matchId
                                }
                                let docC = try HTML(html: rateB.innerHTML!, encoding: String.Encoding.utf8)
                                if let matchStatus = docC.xpath("//div[@class='m01']/h2/text()[1]")[0].text {
                                    matchObj.matchStatus = matchStatus
                                }
                                if let matchDate = docC.xpath("//span[@class='MatchDate']")[0].text {
                                    matchObj.matchDate = matchDate
                                }
                                if let homeTeamId = docC.xpath("//div[@class='matchLeft']/p[@class='homeLogo']")[0]["data-id"] {
                                    matchObj.homeTeamId = homeTeamId
                                }
                                if let homeTeamLogoUrl = docC.xpath("//div[@class='matchLeft']/p[@class='homeLogo']/img")[0]["src"] {
                                    matchObj.homeTeamLogoUrl = homeTeamLogoUrl
                                }
                                if let homeTeamName = docC.xpath("//div[@class='matchLeft']/p[@class='homeLogo']/span")[0].text {
                                    matchObj.homeTeamName = homeTeamName
                                }
                                if let guestTeamId = docC.xpath("//div[@class='matchLeft']/p[@class='guestLogo']")[0]["data-id"] {
                                    matchObj.guestTeamId = guestTeamId
                                }
                                if let guestTeamLogoUrl = docC.xpath("//div[@class='matchLeft']/p[@class='guestLogo']/img")[0]["src"] {
                                    matchObj.guestTeamLogoUrl = guestTeamLogoUrl
                                }
                                if let guestTeamName = docC.xpath("//div[@class='matchLeft']/p[@class='guestLogo']/span")[0].text {
                                    matchObj.guestTeamName = guestTeamName
                                }
                                
                                if let homeTeam1stScore = docC.xpath("//p[@class='scoreItem mhomeScore']/span")[0].text {
                                    matchObj.homeTeam1stScore = homeTeam1stScore
                                }
                                if let homeTeam2ndScore = docC.xpath("//p[@class='scoreItem mhomeScore']/span")[1].text {
                                    matchObj.homeTeam2ndScore = homeTeam2ndScore
                                }
                                if let homeTeam3rdScore = docC.xpath("//p[@class='scoreItem mhomeScore']/span")[2].text {
                                    matchObj.homeTeam3rdScore = homeTeam3rdScore
                                }
                                if let homeTeam4thScore = docC.xpath("//p[@class='scoreItem mhomeScore']/span")[3].text {
                                    matchObj.homeTeam4thScore = homeTeam4thScore
                                }
                                
                                if let guestTeam1stScore = docC.xpath("//p[@class='scoreItem mguestScore']/span")[0].text {
                                    matchObj.guestTeam1stScore = guestTeam1stScore
                                }
                                if let guestTeam2ndScore = docC.xpath("//p[@class='scoreItem mguestScore']/span")[1].text {
                                    matchObj.guestTeam2ndScore = guestTeam2ndScore
                                }
                                if let guestTeam3rdScore = docC.xpath("//p[@class='scoreItem mguestScore']/span")[2].text {
                                    matchObj.guestTeam3rdScore = guestTeam3rdScore
                                }
                                if let guestTeam4thScore = docC.xpath("//p[@class='scoreItem mguestScore']/span")[3].text {
                                    matchObj.guestTeam4thScore = guestTeam4thScore
                                }
                                
                                if let homeTeamTotalScore = docC.xpath("//div[@class='matchRight']/p[@class]")[1].text {
                                    matchObj.homeTeamTotalScore = homeTeamTotalScore
                                }
                                if let guestTeamTotalScore = docC.xpath("//div[@class='matchRight']/p[@class]")[2].text {
                                    matchObj.guestTeamTotalScore = guestTeamTotalScore
                                }
                                
                                let rateCtemp = docC.xpath("//div[@class='m02']")
                                if (rateCtemp.count > 0) {
                                    
                                    if let homeMostScorePlayerName = docC.xpath("//div[@class='m02']/div[2]/span[3]")[0].text {
                                        matchObj.homeMostScorePlayerName = homeMostScorePlayerName
                                    }
                                    if let homeMostScorePoint = docC.xpath("//div[@class='m02']/div[2]/span[4]")[0].text {
                                        matchObj.homeMostScorePoint = homeMostScorePoint
                                    }
                                    
                                    if let guestMostScorePlayerName = docC.xpath("//div[@class='m02']/div[2]/span[6]")[0].text {
                                        matchObj.guestMostScorePlayerName = guestMostScorePlayerName
                                    }
                                    if let guestMostScorePoint = docC.xpath("//div[@class='m02']/div[2]/span[7]")[0].text {
                                        matchObj.guestMostScorePoint = guestMostScorePoint
                                    }
                                    
                                    if let homeMostReboundPlayerName = docC.xpath("//div[@class='m02']/div[3]/span[3]")[0].text {
                                        matchObj.homeMostReboundPlayerName = homeMostReboundPlayerName
                                    }
                                    if let homeMostReboundPoint = docC.xpath("//div[@class='m02']/div[3]/span[4]")[0].text {
                                        matchObj.homeMostReboundPoint = homeMostReboundPoint
                                    }
                                    
                                    if let guestMostReboundPlayerName = docC.xpath("//div[@class='m02']/div[3]/span[6]")[0].text {
                                        matchObj.guestMostReboundPlayerName = guestMostReboundPlayerName
                                    }
                                    if let guestMostReboundPoint = docC.xpath("//div[@class='m02']/div[3]/span[7]")[0].text {
                                        matchObj.guestMostReboundPoint = guestMostReboundPoint
                                    }
                                    
                                    if let homeMostAssistPlayerName = docC.xpath("//div[@class='m02']/div[4]/span[3]")[0].text {
                                        matchObj.homeMostAssistPlayerName = homeMostAssistPlayerName
                                    }
                                    if let homeMostAssistPoint = docC.xpath("//div[@class='m02']/div[4]/span[4]")[0].text {
                                        matchObj.homeMostAssistPoint = homeMostAssistPoint
                                    }
                                    
                                    if let guestMostAssistPlayerName = docC.xpath("//div[@class='m02']/div[4]/span[6]")[0].text {
                                        matchObj.guestMostAssistPlayerName = guestMostAssistPlayerName
                                    }
                                    if let guestMostAssistPoint = docC.xpath("//div[@class='m02']/div[4]/span[7]")[0].text {
                                        matchObj.guestMostAssistPoint = guestMostAssistPoint
                                    }
                                
                                }
                                
                                matchArray.append(matchObj)
                            }
                            self.getWebViewDataCompletedCallback(matchArray)
                            
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
    
    func getWebViewDataCompletedCallback(_ matchArray: [ObjectMatch]) {
        
        DispatchQueue.main.async {
            self.newMatchTV.matchArray = matchArray
            self.newMatchTV.reloadData()
            self.mainInstance.stopIndicator {
                
            }
        }
        
    }

}
