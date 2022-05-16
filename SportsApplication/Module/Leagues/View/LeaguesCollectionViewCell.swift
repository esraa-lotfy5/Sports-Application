//
//  LeaguesCollectionViewCell.swift
//  SportsApplication
//
//  Created by Esraa Lotfy  on 5/13/22.
//  Copyright © 2022 iti. All rights reserved.
//

import UIKit

class LeaguesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var leagugeImage: UIImageView!
    @IBOutlet weak var leagueNameLabel: UILabel!
    
    @IBOutlet weak var youtubeIcon: UIButton!
    
    @IBAction func youtubeImage(_ sender: Any) {
        
        print("Tapped on Image")
               
               let youtubeId = "SxTYjptEzZs"
                  var youtubeUrl = NSURL(string:"youtube://\(youtubeId)")!
               if UIApplication.shared.canOpenURL(youtubeUrl as URL){
                   UIApplication.shared.openURL(youtubeUrl as URL)
                  } else{
                          youtubeUrl = NSURL(string:"https://www.youtube.com/watch?v=\(youtubeId)")!
                   UIApplication.shared.openURL(youtubeUrl as URL)
                  }
        
    }
    
}
