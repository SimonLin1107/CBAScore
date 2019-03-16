//
//  NewMatchTableView.swift
//  WKWebViewExample
//
//  Created by Apple on 2019/3/12.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class NewMatchTableView: UITableView, UITableViewDelegate, UITableViewDataSource {

    var vcInstance:NewMatchViewController!
    var matchArray: [ObjectMatch] = [ObjectMatch]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matchArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newMatchTVC", for: indexPath) as! NewMatchTableViewCell
        
        cell.tag = indexPath.row
        cell.homeTeamImageView.image = nil
        downloadImage(url: matchArray[indexPath.row].homeTeamLogoUrl) { (image) in
            if (cell.tag == indexPath.row) {
                cell.homeTeamImageView.image = image
            }
        }
        cell.guestTeamImageView.image = nil
        downloadImage(url: matchArray[indexPath.row].guestTeamLogoUrl) { (image) in
            if (cell.tag == indexPath.row) {
                cell.guestTeamImageView.image = image
            }
        }
        
        cell.homeTeamNameLabel.text = matchArray[indexPath.row].homeTeamName
        cell.guestTeamNameLabel.text = matchArray[indexPath.row].guestTeamName
        cell.matchStatusLabel.text = matchArray[indexPath.row].matchStatus
        cell.matchDateLabel.text = matchArray[indexPath.row].matchDate
        cell.homeTeam1stScoreLabel.text = matchArray[indexPath.row].homeTeam1stScore
        cell.guestTeam1stScoreLabel.text = matchArray[indexPath.row].guestTeam1stScore
        cell.homeTeam2ndScoreLabel.text = matchArray[indexPath.row].homeTeam2ndScore
        cell.guestTeam2ndScoreLabel.text = matchArray[indexPath.row].guestTeam2ndScore
        cell.homeTeam3rdScoreLabel.text = matchArray[indexPath.row].homeTeam3rdScore
        cell.guestTeam3rdScoreLabel.text = matchArray[indexPath.row].guestTeam3rdScore
        cell.homeTeam4thScoreLabel.text = matchArray[indexPath.row].homeTeam4thScore
        cell.guestTeam4thScoreLabel.text = matchArray[indexPath.row].guestTeam4thScore
        cell.homeTeamTotalScoreLabel.text = matchArray[indexPath.row].homeTeamTotalScore
        cell.guestTeamTotalScoreLabel.text = matchArray[indexPath.row].guestTeamTotalScore
        cell.homeTeamMostScoreLabel.text = matchArray[indexPath.row].homeMostScorePlayerName + " (" + matchArray[indexPath.row].homeMostScorePoint + ")"
        cell.guestTeamMostScoreLabel.text = matchArray[indexPath.row].guestMostScorePlayerName + " (" + matchArray[indexPath.row].guestMostScorePoint + ")"
        cell.homeTeamMostReboundLabel.text = matchArray[indexPath.row].homeMostReboundPlayerName + " (" + matchArray[indexPath.row].homeMostReboundPoint + ")"
        cell.guestTeamMostReboundLabel.text = matchArray[indexPath.row].guestMostReboundPlayerName + " (" + matchArray[indexPath.row].guestMostReboundPoint + ")"
        cell.homeTeamMostAssistLabel.text = matchArray[indexPath.row].homeMostAssistPlayerName + " (" + matchArray[indexPath.row].homeMostAssistPoint + ")"
        cell.guestTeamMostAssistLabel.text = matchArray[indexPath.row].guestMostAssistPlayerName + " (" + matchArray[indexPath.row].guestMostAssistPoint + ")"
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

}
