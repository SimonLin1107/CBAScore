//
//  TeamTableView.swift
//  WKWebViewExample
//
//  Created by Apple on 2019/3/11.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class TeamTableView: UITableView, UITableViewDelegate, UITableViewDataSource {
    
    var vcInstance:TeamViewController!
    var teamArray: [ObjectTeam] = [ObjectTeam]()

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teamArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "teamTVC", for: indexPath) as! TeamTableViewCell
        
        cell.teamNameLabel.text = teamArray[indexPath.row].teamName
        cell.teamImageView.image = UIImage(named: teamArray[indexPath.row].teamLogoUrl)
        cell.tag = indexPath.row
        
        cell.teamSelectBtn.addTargetClosure { (sender) in
            
            self.vcInstance.mainInstance.currentPage.append(7)
           self.vcInstance.mainInstance.currentValue.append([self.teamArray[cell.tag].teamId,self.teamArray[cell.tag].teamName])
            
            self.vcInstance.mainInstance.setPlayerContent(teamId: self.teamArray[cell.tag].teamId, titleTeamName: self.teamArray[cell.tag].teamName, callback: {
                
            })
            
        }
        
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
