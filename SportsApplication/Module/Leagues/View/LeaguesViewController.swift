//
//  LeaguesViewController.swift
//  SportsApplication
//
//  Created by Esraa Lotfy  on 5/13/22.
//  Copyright © 2022 iti. All rights reserved.
//

import UIKit

class LeaguesViewController: UIViewController {

    //  object of presenter
    var presenter : LeaguesPresenterProtocol!
    //  response result array from network
    var responseResultArray  : [League] = []
    //  country Name and Sport Name
    var sportName : String = ""
    var countryName : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //  variables initializations
        presenter = LeaguesPresenter(networkService: NetworkManager.delegate, view: self)
        let parameters = ["c":countryName , "s":sportName]
        print("parameters: \(parameters)")
        presenter.getSportsListItems(urlID: 2, parameteres: parameters)
    }
}

extension LeaguesViewController : LeaguesViewControllerProtocol{
    func renderCollectionViewFromNetwork(response : Any){
        responseResultArray = (response as! LeaguesResponse).countries
        print("League Name: \(responseResultArray[0].strLeague ?? "No League Name")")
        //self.sportsCollection.reloadData()
    }
}

