//
//  TeamTableView.swift
//  WKWebViewExample
//
//  Created by Apple on 2019/3/11.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class TeamMatchTableView: UITableView, UITableViewDelegate, UITableViewDataSource {
    
    var vcInstance:TeamMatchViewController!
    var teamMatchArray: [ObjectTeam] = [ObjectTeam]()

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teamMatchArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "teamMatchTVC", for: indexPath) as! TeamMatchTableViewCell
        
        cell.teamNameLabel.text = teamMatchArray[indexPath.row].teamName
        cell.teamImageView.image = UIImage(named: teamMatchArray[indexPath.row].teamLogoUrl)
        cell.tag = indexPath.row
        
        cell.teamSelectBtn.addTargetClosure { (sender) in
            
            self.vcInstance.mainInstance.currentPage.append(8)
            self.vcInstance.mainInstance.currentValue.append([self.teamMatchArray[cell.tag].teamId,self.teamMatchArray[cell.tag].teamName])
            
            
            self.vcInstance.mainInstance.setTeamGameContent(teamId: self.teamMatchArray[cell.tag].teamId, titleTeamName: self.teamMatchArray[cell.tag].teamName, callback: {
                
            })
            
            self.vcInstance.dismiss(animated: true, completion: {
                
            })
            
        }
        
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
