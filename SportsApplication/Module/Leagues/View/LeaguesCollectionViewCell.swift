//
//  LeaguesCollectionViewCell.swift
//  SportsApplication
//
//  Created by Esraa Lotfy  on 5/13/22.
//  Copyright © 2022 iti. All rights reserved.
//

import UIKit

class LeaguesCollectionViewCell: UICollectionViewCell {
    
    var url : String = ""
    
    var youtubeBtnPressed : (()-> Void)?
    
    @IBOutlet weak var leagugeImage: UIImageView!
    @IBOutlet weak var leagueNameLabel: UILabel!
    
   // @IBOutlet weak var youtubeIcon: UIButton!
    
    
    @IBOutlet weak var btnYoutube: UIButton!
    
//    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
//        print("Button youtube: \(btnYoutube == nil)")
//        var view = btnYoutube.hitTest(btnYoutube.convert(point, from: self), with: event)
//        if view == nil {
//            view = super.hitTest(point, with: event)
//        }
//
//        return view
//    }
    
    /*@IBAction func youtubeBtn(_ sender: UIButton) {
   
        
        print("Tapped on Image")
        print(url)
               
               let youtubeId = "SxTYjptEzZs"
                  var youtubeUrl = NSURL(string:"youtube://\(youtubeId)")!
               if UIApplication.shared.canOpenURL(youtubeUrl as URL){
                   UIApplication.shared.openURL(youtubeUrl as URL)
                  } else{
                          youtubeUrl = NSURL(string:"https://www.youtube.com/watch?v=\(youtubeId)")!
                   UIApplication.shared.openURL(youtubeUrl as URL)
                  }
        
    }*/
//    @IBAction func youtubeBtn(_ sender: UIButton) {
//        youtubeBtnPressed?()
//        print("Tapped on Image")
//        print(url)
                      
//      let youtubeId = "SxTYjptEzZs"
//     var youtubeUrl = NSURL(string:"youtube://\(youtubeId)")!
//      if UIApplication.shared.canOpenURL(youtubeUrl as URL){
//          UIApplication.shared.openURL(youtubeUrl as URL)
//     } else{
//         youtubeUrl = NSURL(string:"https://www.youtube.com/watch?v=\(youtubeId)")!
//          UIApplication.shared.openURL(youtubeUrl as URL)
//     }
//}
}
