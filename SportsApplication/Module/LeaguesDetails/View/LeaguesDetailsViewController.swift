//
//  LeaguesDetailsViewController.swift
//  SportsApplication
//
//  Created by nihal yasser khamis on 5/15/22.
//  Copyright © 2022 iti. All rights reserved.
//

import UIKit

class LeaguesDetailsViewController: UIViewController {
    
    var sportName : String = ""

    @IBAction func backBtn(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)

    }
    
    @IBOutlet weak var leagueName: UILabel!
    @IBOutlet weak var upcomingEvents: UILabel!
    
    @IBAction func favBtn(_ sender: UIButton) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        leagueName.text = sportName
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
