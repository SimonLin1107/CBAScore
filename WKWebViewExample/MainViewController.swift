//
//  MainViewController.swift
//  WKWebViewExample
//
//  Created by Apple on 2019/3/13.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var indicatorView: UIView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var indicatorSelectBtn: UIButton!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var menuBtn: UIButton!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var newsBtn: UIButton!
    @IBOutlet weak var matchsBtn: UIButton!
    @IBOutlet weak var picturesBtn: UIButton!
    @IBOutlet weak var teamsBtn: UIButton!
    @IBOutlet weak var shareBtn: UIButton!
    
    var currentVC:UIViewController?
    var currentPage:[Int] = [Int]()
    var currentValue:[[String]] = [[String]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        indicator.stopAnimating()
        indicatorView.isHidden = true
        indicatorSelectBtn.addTargetClosure { (sender) in
            self.stopIndicator {
                
            }
        }
        
        currentPage = [Int]()
        currentValue = [[String]]()
        self.currentPage.append(1)
        self.currentValue.append([""])
        self.setNewsContent { }
        
        newsBtn.addTargetClosure { (sender) in
            if (self.currentPage.last! != 1) {
                self.currentPage.append(1)
                self.currentValue.append([""])
                self.setNewsContent { }
            }
        }
        
        matchsBtn.addTargetClosure { (sender) in
            if (self.currentPage.last! != 2) {
                self.currentPage.append(2)
                self.currentValue.append([""])
                self.setNewMatchContent { }
            }
        }
        
        picturesBtn.addTargetClosure { (sender) in
            
            if (self.currentPage.last! != 3) {
                self.currentPage.append(3)
                self.currentValue.append([""])
                self.setPictureContent { }
            }
            
        }
        
        teamsBtn.addTargetClosure { (sender) in
            
            if (self.currentPage.last! != 4) {
                self.currentPage.append(4)
                self.currentValue.append([""])
                self.setTeamContent { }
            }

        }
        
        backBtn.addTargetClosure { (sender) in
            
            if (self.currentPage.count > 1) {
                self.currentPage.removeLast()
                self.currentValue.removeLast()
                if (self.currentPage[self.currentPage.count-1] == 1) {
                    self.setNewsContent {
                        
                    }
                } else if (self.currentPage[self.currentPage.count-1] == 2) {
                    self.setNewMatchContent {
                        
                    }
                } else if (self.currentPage[self.currentPage.count-1] == 3) {
                    self.setPictureContent {
                        
                    }
                } else if (self.currentPage[self.currentPage.count-1] == 4) {
                    self.setTeamContent {
                        
                    }
                } else if (self.currentPage[self.currentPage.count-1] == 5) {
                    let url = self.currentValue.last![0]
                    self.setNewsDetailContent(url: url, callback: { })
                } else if (self.currentPage[self.currentPage.count-1] == 6) {
                    let galleryId = self.currentValue.last![0]
                    self.setPictureDetailContent(galleryId: galleryId, callback: { })
                } else if (self.currentPage[self.currentPage.count-1] == 7) {
                    let teamId = self.currentValue.last![0]
                    let titleName = self.currentValue.last![1]
                    self.setPlayerContent(teamId: teamId, titleTeamName: titleName, callback: { })
                } else if (self.currentPage[self.currentPage.count-1] == 8) {
                    let teamId = self.currentValue.last![0]
                    let titleName = self.currentValue.last![1]
                    self.setTeamGameContent(teamId: teamId, titleTeamName: titleName, callback: { })
                } else if (self.currentPage[self.currentPage.count-1] == 9) {
                    let playerId = self.currentValue.last![0]
                    let titleName = self.currentValue.last![1]
                    self.setPlayerDetailContent(playerId: playerId, titlePlayerName: titleName, callback: { })
                }
                
            }
            
        }
        
        menuBtn.addTargetClosure { (sender) in

            let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "teamMatchVC") as! TeamMatchViewController
            controller.mainInstance = self

            controller.preferredContentSize = CGSize(width: 250, height: 400)

            let presentationController = AlwaysPresentAsPopover.configurePresentation(forController: controller)
            presentationController.sourceView = sender
            presentationController.sourceRect = sender.bounds
            presentationController.permittedArrowDirections = [.down, .up]
            self.present(controller, animated: true)

        }
        
        shareBtn.addTargetClosure { (sender) in
            self.startIndicator {
                
                self.getShareLink(callback: { (title, link) in
                    
                    self.stopIndicator {
                        
                        if let urlToShare = URL(string: link) {
                            let objToShare = [title,urlToShare] as [Any]
                            let shareVC = UIActivityViewController(activityItems: objToShare, applicationActivities: nil)
                            shareVC.popoverPresentationController?.sourceView = sender
                            self.present(shareVC, animated: true, completion: nil)
                        }
                        
                    }
                    
                })
                
            }
        }
        
    }
    
    func getShareLink(callback: @escaping (_ title:String, _ link:String) -> Void) {
        
        var headers:[String:String] = [String:String]()
        headers["Content-Type"] = "application/json"
        headers["X-LC-Id"] = "dewVBh3bQhLIgn5LIe6jkmyO-gzGzoHsz"
        headers["X-LC-Key"] = "R816QIH8ghrKRaTl4fUW3q0G"
        let maintenanceUrl = "https://leancloud.cn:443/1.1/classes/AppShare?limit=1"
        downloadJasonDataAsDictionary(url: maintenanceUrl, type: "GET", headers: headers, uploadDic: nil) { (resultStatus, resultHeaders, resultDic, errorString) in
            
            if let dlArr = resultDic["results"] as? [Any] {
                if (dlArr.count > 0) {
                    if let dlDic = dlArr[0] as? [String:Any] {
                        if let dlLink = dlDic["DownloadLink"] as? String {
                            if let dlTitle = dlDic["DownloadTitle"] as? String {
                                callback(dlTitle,dlLink)
                            } else {
                                callback("",dlLink)
                            }
                        } else {
                            callback("","")
                        }
                    } else {
                        callback("","")
                    }
                } else {
                    callback("","")
                }
            } else {
                callback("","")
            }
        }
        
    }
    
    func startIndicator(callback: @escaping () -> Void) {
        DispatchQueue.main.async {
            self.indicator.startAnimating()
            self.indicatorView.isHidden = false
            callback()
        }
    }
    
    func stopIndicator(callback: @escaping () -> Void) {
        DispatchQueue.main.async {
            self.indicatorView.isHidden = true
            self.indicator.stopAnimating()
            callback()
        }
    }
    
    func setNewsContent(callback: @escaping () -> Void) {
        // page 1
        self.titleLabel.text = "新闻"

        let subVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "newsVC") as! NewsViewController
        subVC.mainInstance = self
        
        addChild(subVC)
        containerView.addSubview(subVC.view)
        subVC.view.translatesAutoresizingMaskIntoConstraints = false
        
        var constraintsB = [NSLayoutConstraint]()
        constraintsB.append(NSLayoutConstraint(item: subVC.view, attribute: .top, relatedBy: .equal, toItem: containerView, attribute: .top, multiplier: 1.0, constant: 0))
        constraintsB.append(NSLayoutConstraint(item: subVC.view, attribute: .left, relatedBy: .equal, toItem: containerView, attribute: .left, multiplier: 1.0, constant: 0))
        constraintsB.append(NSLayoutConstraint(item: subVC.view, attribute: .right, relatedBy: .equal, toItem: containerView, attribute: .right, multiplier: 1.0, constant: 0))
        constraintsB.append(NSLayoutConstraint(item: subVC.view, attribute: .bottom, relatedBy: .equal, toItem: containerView, attribute: .bottom, multiplier: 1.0, constant: 0))
        self.view.addConstraints(constraintsB)
        
        subVC.didMove(toParent: self)
        
        if (currentVC != nil) {
            currentVC!.removeFromParent()
            currentVC = nil
        }
        
        currentVC = subVC
        
        callback()
        
    }
    
    func setNewMatchContent(callback: @escaping () -> Void) {
        // page 2
        self.titleLabel.text = "赛程"
        let subVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "newMatchVC") as! NewMatchViewController
        subVC.mainInstance = self
        
        addChild(subVC)
        containerView.addSubview(subVC.view)
        subVC.view.translatesAutoresizingMaskIntoConstraints = false
        
        var constraintsB = [NSLayoutConstraint]()
        constraintsB.append(NSLayoutConstraint(item: subVC.view, attribute: .top, relatedBy: .equal, toItem: containerView, attribute: .top, multiplier: 1.0, constant: 0))
        constraintsB.append(NSLayoutConstraint(item: subVC.view, attribute: .left, relatedBy: .equal, toItem: containerView, attribute: .left, multiplier: 1.0, constant: 0))
        constraintsB.append(NSLayoutConstraint(item: subVC.view, attribute: .right, relatedBy: .equal, toItem: containerView, attribute: .right, multiplier: 1.0, constant: 0))
        constraintsB.append(NSLayoutConstraint(item: subVC.view, attribute: .bottom, relatedBy: .equal, toItem: containerView, attribute: .bottom, multiplier: 1.0, constant: 0))
        self.view.addConstraints(constraintsB)
        
        subVC.didMove(toParent: self)
        
        if (currentVC != nil) {
            currentVC!.removeFromParent()
            currentVC = nil
        }
        
        currentVC = subVC
        
        callback()
    }
    
    func setPictureContent(callback: @escaping () -> Void) {
        // page 3
        self.titleLabel.text = "图集"
        let subVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "pictureVC") as! PictureViewController
        subVC.mainInstance = self
        
        addChild(subVC)
        containerView.addSubview(subVC.view)
        subVC.view.translatesAutoresizingMaskIntoConstraints = false
        
        var constraintsB = [NSLayoutConstraint]()
        constraintsB.append(NSLayoutConstraint(item: subVC.view, attribute: .top, relatedBy: .equal, toItem: containerView, attribute: .top, multiplier: 1.0, constant: 0))
        constraintsB.append(NSLayoutConstraint(item: subVC.view, attribute: .left, relatedBy: .equal, toItem: containerView, attribute: .left, multiplier: 1.0, constant: 0))
        constraintsB.append(NSLayoutConstraint(item: subVC.view, attribute: .right, relatedBy: .equal, toItem: containerView, attribute: .right, multiplier: 1.0, constant: 0))
        constraintsB.append(NSLayoutConstraint(item: subVC.view, attribute: .bottom, relatedBy: .equal, toItem: containerView, attribute: .bottom, multiplier: 1.0, constant: 0))
        self.view.addConstraints(constraintsB)
        
        subVC.didMove(toParent: self)
        
        if (currentVC != nil) {
            currentVC!.removeFromParent()
            currentVC = nil
        }
        
        currentVC = subVC
        
        callback()
        
    }
    
    func setTeamContent(callback: @escaping () -> Void) {
        // page 4
        self.titleLabel.text = "球队"
        let subVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "teamVC") as! TeamViewController
        subVC.mainInstance = self
        
        addChild(subVC)
        containerView.addSubview(subVC.view)
        subVC.view.translatesAutoresizingMaskIntoConstraints = false
        
        var constraintsB = [NSLayoutConstraint]()
        constraintsB.append(NSLayoutConstraint(item: subVC.view, attribute: .top, relatedBy: .equal, toItem: containerView, attribute: .top, multiplier: 1.0, constant: 0))
        constraintsB.append(NSLayoutConstraint(item: subVC.view, attribute: .left, relatedBy: .equal, toItem: containerView, attribute: .left, multiplier: 1.0, constant: 0))
        constraintsB.append(NSLayoutConstraint(item: subVC.view, attribute: .right, relatedBy: .equal, toItem: containerView, attribute: .right, multiplier: 1.0, constant: 0))
        constraintsB.append(NSLayoutConstraint(item: subVC.view, attribute: .bottom, relatedBy: .equal, toItem: containerView, attribute: .bottom, multiplier: 1.0, constant: 0))
        self.view.addConstraints(constraintsB)
        
        subVC.didMove(toParent: self)
        
        if (currentVC != nil) {
            currentVC!.removeFromParent()
            currentVC = nil
        }
        
        currentVC = subVC
        
        callback()
    }
    
    func setNewsDetailContent(url:String, callback: @escaping () -> Void) {
        // page 5
        self.titleLabel.text = "新闻内容"
        let subVC = HtmlViewController()
        subVC.mainInstance = self
        subVC.isMantanenceUrl = ""
        subVC.urlType = 1
        subVC.notMantanenceUrl = url
        
        addChild(subVC)
        containerView.addSubview(subVC.view)
        subVC.view.translatesAutoresizingMaskIntoConstraints = false
        
        var constraintsB = [NSLayoutConstraint]()
        constraintsB.append(NSLayoutConstraint(item: subVC.view, attribute: .top, relatedBy: .equal, toItem: containerView, attribute: .top, multiplier: 1.0, constant: 0))
        constraintsB.append(NSLayoutConstraint(item: subVC.view, attribute: .left, relatedBy: .equal, toItem: containerView, attribute: .left, multiplier: 1.0, constant: 0))
        constraintsB.append(NSLayoutConstraint(item: subVC.view, attribute: .right, relatedBy: .equal, toItem: containerView, attribute: .right, multiplier: 1.0, constant: 0))
        constraintsB.append(NSLayoutConstraint(item: subVC.view, attribute: .bottom, relatedBy: .equal, toItem: containerView, attribute: .bottom, multiplier: 1.0, constant: 0))
        self.view.addConstraints(constraintsB)
        
        subVC.didMove(toParent: self)
        
        if (currentVC != nil) {
            currentVC!.removeFromParent()
            currentVC = nil
        }
        
        currentVC = subVC
        
        callback()
    }
    
    func setPictureDetailContent(galleryId:String, callback: @escaping () -> Void) {
        // page 6
        self.titleLabel.text = "图集详情"

        let subVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "pictureDetailVC") as! PictureDetailViewController
        subVC.mainInstance = self
        subVC.galleryId = galleryId
        
        addChild(subVC)
        containerView.addSubview(subVC.view)
        subVC.view.translatesAutoresizingMaskIntoConstraints = false
        
        var constraintsB = [NSLayoutConstraint]()
        constraintsB.append(NSLayoutConstraint(item: subVC.view, attribute: .top, relatedBy: .equal, toItem: containerView, attribute: .top, multiplier: 1.0, constant: 0))
        constraintsB.append(NSLayoutConstraint(item: subVC.view, attribute: .left, relatedBy: .equal, toItem: containerView, attribute: .left, multiplier: 1.0, constant: 0))
        constraintsB.append(NSLayoutConstraint(item: subVC.view, attribute: .right, relatedBy: .equal, toItem: containerView, attribute: .right, multiplier: 1.0, constant: 0))
        constraintsB.append(NSLayoutConstraint(item: subVC.view, attribute: .bottom, relatedBy: .equal, toItem: containerView, attribute: .bottom, multiplier: 1.0, constant: 0))
        self.view.addConstraints(constraintsB)
        
        subVC.didMove(toParent: self)
        
        if (currentVC != nil) {
            currentVC!.removeFromParent()
            currentVC = nil
        }
        
        currentVC = subVC
        
        callback()
        
    }
    
    func setPlayerContent(teamId:String, titleTeamName:String, callback: @escaping () -> Void) {
        // page 7
        self.titleLabel.text = titleTeamName

        let subVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "playerVC") as! PlayerViewController
        subVC.mainInstance = self
        subVC.teamId = teamId
        
        addChild(subVC)
        containerView.addSubview(subVC.view)
        subVC.view.translatesAutoresizingMaskIntoConstraints = false
        
        var constraintsB = [NSLayoutConstraint]()
        constraintsB.append(NSLayoutConstraint(item: subVC.view, attribute: .top, relatedBy: .equal, toItem: containerView, attribute: .top, multiplier: 1.0, constant: 0))
        constraintsB.append(NSLayoutConstraint(item: subVC.view, attribute: .left, relatedBy: .equal, toItem: containerView, attribute: .left, multiplier: 1.0, constant: 0))
        constraintsB.append(NSLayoutConstraint(item: subVC.view, attribute: .right, relatedBy: .equal, toItem: containerView, attribute: .right, multiplier: 1.0, constant: 0))
        constraintsB.append(NSLayoutConstraint(item: subVC.view, attribute: .bottom, relatedBy: .equal, toItem: containerView, attribute: .bottom, multiplier: 1.0, constant: 0))
        self.view.addConstraints(constraintsB)
        
        subVC.didMove(toParent: self)
        
        if (currentVC != nil) {
            currentVC!.removeFromParent()
            currentVC = nil
        }
        
        currentVC = subVC
        
        callback()
    }
    
    func setTeamGameContent(teamId:String, titleTeamName:String, callback: @escaping () -> Void) {
        // page 8
        self.titleLabel.text = titleTeamName
        
        let subVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "teamGameVC") as! TeamGameViewController
        subVC.mainInstance = self
        subVC.teamId = teamId
        
        addChild(subVC)
        containerView.addSubview(subVC.view)
        subVC.view.translatesAutoresizingMaskIntoConstraints = false
        
        var constraintsB = [NSLayoutConstraint]()
        constraintsB.append(NSLayoutConstraint(item: subVC.view, attribute: .top, relatedBy: .equal, toItem: containerView, attribute: .top, multiplier: 1.0, constant: 0))
        constraintsB.append(NSLayoutConstraint(item: subVC.view, attribute: .left, relatedBy: .equal, toItem: containerView, attribute: .left, multiplier: 1.0, constant: 0))
        constraintsB.append(NSLayoutConstraint(item: subVC.view, attribute: .right, relatedBy: .equal, toItem: containerView, attribute: .right, multiplier: 1.0, constant: 0))
        constraintsB.append(NSLayoutConstraint(item: subVC.view, attribute: .bottom, relatedBy: .equal, toItem: containerView, attribute: .bottom, multiplier: 1.0, constant: 0))
        self.view.addConstraints(constraintsB)
        
        subVC.didMove(toParent: self)
        
        if (currentVC != nil) {
            currentVC!.removeFromParent()
            currentVC = nil
        }
        
        currentVC = subVC
        
        callback()
    }
    
    func setPlayerDetailContent(playerId:String, titlePlayerName:String, callback: @escaping () -> Void) {
        // page 9
        self.titleLabel.text = titlePlayerName
        
        let subVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "playerDetailVC") as! PlayerDetailViewController
        subVC.mainInstance = self
        subVC.playerId = playerId
        
        addChild(subVC)
        containerView.addSubview(subVC.view)
        subVC.view.translatesAutoresizingMaskIntoConstraints = false
        
        var constraintsB = [NSLayoutConstraint]()
        constraintsB.append(NSLayoutConstraint(item: subVC.view, attribute: .top, relatedBy: .equal, toItem: containerView, attribute: .top, multiplier: 1.0, constant: 0))
        constraintsB.append(NSLayoutConstraint(item: subVC.view, attribute: .left, relatedBy: .equal, toItem: containerView, attribute: .left, multiplier: 1.0, constant: 0))
        constraintsB.append(NSLayoutConstraint(item: subVC.view, attribute: .right, relatedBy: .equal, toItem: containerView, attribute: .right, multiplier: 1.0, constant: 0))
        constraintsB.append(NSLayoutConstraint(item: subVC.view, attribute: .bottom, relatedBy: .equal, toItem: containerView, attribute: .bottom, multiplier: 1.0, constant: 0))
        self.view.addConstraints(constraintsB)
        
        subVC.didMove(toParent: self)
        
        if (currentVC != nil) {
            currentVC!.removeFromParent()
            currentVC = nil
        }
        
        currentVC = subVC
        
        callback()
    }

}
