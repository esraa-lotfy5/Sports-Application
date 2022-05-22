//
//  TeamsViewController.swift
//  SportsApplication
//
//  Created by Esraa Lotfy  on 5/21/22.
//  Copyright © 2022 iti. All rights reserved.
//

import UIKit

class TeamsViewController: UIViewController {
    
    //  screen team object
    var team : Team = Team()
    
    //  UI components
    @IBOutlet weak var teamBadge: UIImageView!
    @IBOutlet weak var teamNameLabel: UILabel!
    @IBOutlet weak var teamFormationLabel: UILabel!
    @IBOutlet weak var teamCountryLabel: UILabel!
    @IBOutlet weak var teamDescriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        teamNameLabel.text = team.strTeam
        teamFormationLabel.text = "Formed in: \(team.intFormedYear ?? "")"
        teamCountryLabel.text = "Country: \(team.strCountry ?? "")"
        teamDescriptionLabel.text = team.strDescriptionEN ?? ""
        let imageURL = URL(string: team.strTeamBadge ?? "")
        teamBadge.kf.setImage(with: imageURL)

        //  cell UI (corner radius for image and cell/layer, background color)
        teamBadge.layer.cornerRadius = teamBadge.frame.size.width/2
        teamBadge.clipsToBounds = true
        teamBadge.backgroundColor = UIColor.white
        teamBadge.layer.borderColor = UIColor.darkGray.cgColor
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension TeamsViewController: TeamsViewControllerProtocol{
    
}
