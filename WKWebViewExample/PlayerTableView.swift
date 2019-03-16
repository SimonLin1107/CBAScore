//
//  PlayerTableView.swift
//  WKWebViewExample
//
//  Created by Apple on 2019/3/11.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class PlayerTableView: UITableView, UITableViewDelegate, UITableViewDataSource {
    
    var vcInstance:PlayerViewController!
    var playerArray:[ObjectPlayer] = [ObjectPlayer]()

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playerArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "playerTVC", for: indexPath) as! PlayerTableViewCell
        
        cell.playerNameLabel.text = playerArray[indexPath.row].playerName
        cell.playerBirthLabel.text = "出生日期：" + playerArray[indexPath.row].playerBirth
        cell.playerNumberLabel.text = playerArray[indexPath.row].playerNumber
        cell.playerPositionLabel.text = playerArray[indexPath.row].playerPosition
        cell.playerHeightLabel.text = playerArray[indexPath.row].playerHeight
        cell.playerWeightLabel.text = playerArray[indexPath.row].playerWeight
        cell.playerAgeLabel.text = playerArray[indexPath.row].playerAge
        
        cell.playerSelectBtn.addTargetClosure { (sender) in
            
            self.vcInstance.mainInstance.currentPage.append(9)
            self.vcInstance.mainInstance.currentValue.append([self.playerArray[indexPath.row].playerId,self.playerArray[indexPath.row].playerName])
            
            self.vcInstance.mainInstance.setPlayerDetailContent(playerId: self.playerArray[indexPath.row].playerId, titlePlayerName: self.playerArray[indexPath.row].playerName, callback: {
                
            })
            
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
