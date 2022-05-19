//
//  LeaguesDetailsViewController.swift
//  SportsApplication
//
//  Created by nihal yasser khamis on 5/15/22.
//  Copyright © 2022 iti. All rights reserved.
//

import UIKit

class LeaguesDetailsViewController: UIViewController {
    
    //  object of presenter
    var presenter : LeaguesDetailsPresenterProtocol!
    
    //  all leagues screen reference
    var allLeaguesScreen : LeaguesViewControllerProtocol!
    
    //  screen league
    var league : CoreDataModel = CoreDataModel()
    
    //  saved leagues in coredata
    var coreDataLeagues : [CoreDataModel] = []
    
    //var sportName : String = ""
    var isLoved : Bool = false
    
    @IBOutlet weak var leagueName: UILabel!
    @IBOutlet weak var upcomingEvents: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //  variables initializations
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        // create refernce to entity/table
        let managedContext = appDelegate.persistentContainer.viewContext
        presenter = LeaguesDetailsPresenter(networkDelegate: NetworkManager.delegate, localModel: CoreDataHandling(context: managedContext), view: self)
        //  fetch all fav leagues
        coreDataLeagues = presenter.fetchLeaguesFromCoreData()
        //  check if league in fav leagues
        for storedLeague in coreDataLeagues{
            if(league.idLeague == storedLeague.idLeague){
                isLoved = true
                print("league already in favourites")
            }
        }
        
        leagueName.text = league.strLeague
    }
    
    @IBAction func backBtn(_ sender: UIButton) {
        allLeaguesScreen.reloadCollectionView()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func favBtn(_ sender: UIButton) {
        if(isLoved){
            isLoved = true
            //delete league from coredata
            presenter.deleteLeagueFromCoreData(league: league)
            //make heart empty
            
            print("not fav league")
        }else{
            isLoved = true
            //  add league in coredata
            presenter.saveLeagueInCoreData(league: league)
            //  make heart filled
            
            print("fav league")
        }
    }
}


extension LeaguesDetailsViewController : LeaguesDetailsViewControllerProtocol{
    
}
