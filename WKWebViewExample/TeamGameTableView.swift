//
//  TeamGameTableView.swift
//  WKWebViewExample
//
//  Created by Apple on 2019/3/14.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class TeamGameTableView: UITableView, UITableViewDelegate, UITableViewDataSource {

    var vcInstance:TeamGameViewController!
    var gameArray:[ObjectGame] = [ObjectGame]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "teamGameTVC", for: indexPath) as! TeamGameTableViewCell
        
        cell.turnLabel.text = gameArray[indexPath.row].gameTurn
        cell.dateLabel.text = gameArray[indexPath.row].gameDate
        cell.homeLabel.text = gameArray[indexPath.row].gameHomeTeam
        cell.scoreLabel.text = gameArray[indexPath.row].gameScore
        cell.guestLabel.text = gameArray[indexPath.row].gameGuestTeam
        cell.resultLabel.text = gameArray[indexPath.row].gameResult
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

}
