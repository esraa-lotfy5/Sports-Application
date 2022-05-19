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
    
    @IBOutlet weak var leaguesDetailsCollection: UICollectionView!
    @IBOutlet weak var latestEventsCollection: UICollectionView!
    @IBOutlet weak var teamsCollection: UICollectionView!
    
    
       //  object of presenter
       var presenter : LeaguesDetailsPresenterProtocol!
       //  response result array from network
       var responseResultArray  : [Event] = []
       // league name
       var selectedLeagueName : String = ""

    
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
        
       //  collection view protocol conformation
       leaguesDetailsCollection.delegate = self
       leaguesDetailsCollection.dataSource = self
        
        latestEventsCollection.delegate = self
        latestEventsCollection.dataSource = self
        
        teamsCollection.delegate = self
        teamsCollection.dataSource = self
               
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

extension LeaguesDetailsViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch collectionView {
               case leaguesDetailsCollection:
                   return 2
               case latestEventsCollection:
                   return 6
               case teamsCollection:
                   return 7
               default:
                   return 6
               }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView {
        case leaguesDetailsCollection:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! LeaguesDetailsCollectionViewCell
                   cell.firstTeamName.text = "Liverpool"
                   cell.secondTeamName.text = "Manchester"
                   cell.leagueTime.text = "9:00"
                   cell.leagueDate.text = "30-6-2022"
                   
                   cell.contentView.layer.cornerRadius = 15.0
            
            // to make image  darker
            let gradientLayer = CAGradientLayer()
            
            gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
            cell.firstTeam.layer.addSublayer(gradientLayer)
            cell.secondTeam.layer.addSublayer(gradientLayer)

                   cell.contentView.backgroundColor = UIColor.black
                   
                   cell.firstTeamName.textColor  = UIColor.white
                   
                   
                   return cell
        case latestEventsCollection:
            let cell2 = collectionView.dequeueReusableCell(withReuseIdentifier: "cell2", for: indexPath) as! LatestEventsCollectionViewCell
                      
                      cell2.firstTeamName.text = "Liverpool"
                      cell2.secondTeamName.text = "Manchester"
                      cell2.time.text = "9:00"
                      cell2.date.text = "30-6-2022"
                      cell2.score.text = "2-2"
                      
                      return cell2
            case teamsCollection:
                let cell3 = collectionView.dequeueReusableCell(withReuseIdentifier: "cell3", for: indexPath) as! TeamsCollectionViewCell
                                 
                cell3.teamName.text = "Arsenal"
            
                       return cell3
        default:
           return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
       layout collectionViewLayout: UICollectionViewLayout,
       sizeForItemAt indexPath: IndexPath) -> CGSize {
           
        let padding: CGFloat =  25
        let collectionViewSize = collectionView.frame.size.width - padding
        
        if (collectionView == leaguesDetailsCollection || collectionView == latestEventsCollection) {
            
                      return CGSize(width: collectionViewSize/1, height: 140)
        }
        
        return CGSize(width: collectionViewSize/3, height: 140)
          
       }
   
}

