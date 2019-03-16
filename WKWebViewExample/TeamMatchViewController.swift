//
//  TeamViewController.swift
//  WKWebViewExample
//
//  Created by Apple on 2019/3/11.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit
import WebKit
import Kanna

class TeamMatchViewController: UIViewController, WKNavigationDelegate {

    var mainInstance:MainViewController!
    @IBOutlet weak var teamMatchTV: TeamMatchTableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        teamMatchTV.dataSource = teamMatchTV.self
        teamMatchTV.delegate = teamMatchTV.self
        teamMatchTV.vcInstance = self
        
        var teamArray:[ObjectTeam] = [ObjectTeam]()
        let teamObj01 = ObjectTeam()
        teamObj01.teamId = "1"
        teamObj01.teamName = "北京首钢"
        teamObj01.teamLogoUrl = "t1.png"
        teamArray.append(teamObj01)
        
        let teamObj02 = ObjectTeam()
        teamObj02.teamId = "2"
        teamObj02.teamName = "新疆广汇汽车"
        teamObj02.teamLogoUrl = "t2.png"
        teamArray.append(teamObj02)
        
        let teamObj03 = ObjectTeam()
        teamObj03.teamId = "3"
        teamObj03.teamName = "广东东莞银行"
        teamObj03.teamLogoUrl = "t3.png"
        teamArray.append(teamObj03)
        
        let teamObj04 = ObjectTeam()
        teamObj04.teamId = "4"
        teamObj04.teamName = "深圳马可波罗"
        teamObj04.teamLogoUrl = "t4.png"
        teamArray.append(teamObj04)
        
        let teamObj05 = ObjectTeam()
        teamObj05.teamId = "5"
        teamObj05.teamName = "浙江广厦控股"
        teamObj05.teamLogoUrl = "t5.png"
        teamArray.append(teamObj05)
        
        let teamObj06 = ObjectTeam()
        teamObj06.teamId = "6"
        teamObj06.teamName = "滨海云商金控"
        teamObj06.teamLogoUrl = "t6.png"
        teamArray.append(teamObj06)
        
        let teamObj07 = ObjectTeam()
        teamObj07.teamId = "7"
        teamObj07.teamName = "辽宁本钢"
        teamObj07.teamLogoUrl = "t7.png"
        teamArray.append(teamObj07)
        
        let teamObj08 = ObjectTeam()
        teamObj08.teamId = "8"
        teamObj08.teamName = "上海哔哩哔哩"
        teamObj08.teamLogoUrl = "t8.png"
        teamArray.append(teamObj08)
        
        let teamObj09 = ObjectTeam()
        teamObj09.teamId = "9"
        teamObj09.teamName = "山东西王"
        teamObj09.teamLogoUrl = "t9.png"
        teamArray.append(teamObj09)
        
        let teamObj10 = ObjectTeam()
        teamObj10.teamId = "10"
        teamObj10.teamName = "福建晋江文旅"
        teamObj10.teamLogoUrl = "t10.png"
        teamArray.append(teamObj10)
        
        let teamObj11 = ObjectTeam()
        teamObj11.teamId = "11"
        teamObj11.teamName = "苏州肯帝亚"
        teamObj11.teamLogoUrl = "t11.png"
        teamArray.append(teamObj11)
        
        let teamObj12 = ObjectTeam()
        teamObj12.teamId = "12"
        teamObj12.teamName = "四川五粮金樽"
        teamObj12.teamLogoUrl = "t12.png"
        teamArray.append(teamObj12)
        
        let teamObj13 = ObjectTeam()
        teamObj13.teamId = "13"
        teamObj13.teamName = "浙江稠州银行"
        teamObj13.teamLogoUrl = "t13.png"
        teamArray.append(teamObj13)
        
        let teamObj14 = ObjectTeam()
        teamObj14.teamId = "14"
        teamObj14.teamName = "九台农商银行"
        teamObj14.teamLogoUrl = "t14.png"
        teamArray.append(teamObj14)
        
        let teamObj15 = ObjectTeam()
        teamObj15.teamId = "15"
        teamObj15.teamName = "时代中国广州"
        teamObj15.teamLogoUrl = "t15.png"
        teamArray.append(teamObj15)
        
        let teamObj16 = ObjectTeam()
        teamObj16.teamId = "16"
        teamObj16.teamName = "山西汾酒股份"
        teamObj16.teamLogoUrl = "t16.png"
        teamArray.append(teamObj16)
        
        let teamObj17 = ObjectTeam()
        teamObj17.teamId = "17"
        teamObj17.teamName = "八一南昌"
        teamObj17.teamLogoUrl = "t17.png"
        teamArray.append(teamObj17)
        
        let teamObj18 = ObjectTeam()
        teamObj18.teamId = "18"
        teamObj18.teamName = "青岛国信双星"
        teamObj18.teamLogoUrl = "t18.png"
        teamArray.append(teamObj18)
        
        let teamObj19 = ObjectTeam()
        teamObj19.teamId = "19"
        teamObj19.teamName = "南京同曦大圣"
        teamObj19.teamLogoUrl = "t19.png"
        teamArray.append(teamObj19)
        
        let teamObj20 = ObjectTeam()
        teamObj20.teamId = "20"
        teamObj20.teamName = "北京农商银行"
        teamObj20.teamLogoUrl = "t20.png"
        teamArray.append(teamObj20)
        
        self.teamMatchTV.teamMatchArray = teamArray
        self.teamMatchTV.reloadData()
        
    }
    

}
