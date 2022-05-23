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
    
    var isLoved : Bool = false
    
    //  response result array from network
    var responseResultArray  : [Event] = []
    // league name
   // var selectedLeagueName : String = ""
    
    //  response result arrays from network
    var latestEventsArray : [Event] = []
    var upcomingEventsArray : [Event] = []
    var teamsArray  : [Team] = []

    @IBOutlet weak var noUpcomingEvents: UIImageView!
    
    
    @IBOutlet weak var leaguesDetailsCollection: UICollectionView!
    @IBOutlet weak var latestEventsCollection: UICollectionView!
    @IBOutlet weak var teamsCollection: UICollectionView!
    @IBOutlet weak var leagueName: UILabel!
    @IBOutlet weak var upcomingEvents: UILabel!
    @IBOutlet weak var heartButton: UIButton!
    
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
                heartButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                heartButton.tintColor = .red
                print("league already in favourites")
            }
        }
        
        // calling presenter

        presenter.getLeaguesDetailsListItems(urlID: 4, parameteres: ["id" : league.idLeague])       //  events
        presenter.getLeaguesDetailsListItems(urlID: 3, parameteres: ["s":league.strSport,"c":league.strCountry])
        
        leagueName.text = league.strLeague
        
        //  teams collection view presenter
        //["s":"Soccer", "c":"England"]
        
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
            isLoved = false
            //delete league from coredata
            presenter.deleteLeagueFromCoreData(league: league)
            //make heart empty
            heartButton.setImage(UIImage(systemName: "heart"), for: .normal)
            heartButton.tintColor = .gray
            
            print("not fav league")
        }else{
            isLoved = true
            //  add league in coredata
            presenter.saveLeagueInCoreData(league: league)
            //  make heart filled
            heartButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            heartButton.tintColor = .red
            print("fav league")
        }
    }
}


extension LeaguesDetailsViewController : LeaguesDetailsViewControllerProtocol{
    func renderCollectionViewFromNetwork(response : Any ,isCountriesEqualNull : Bool){
//        if(isCountriesEqualNull){
//           _ = (response as! NullReponse)
//           responseResultArray = []
//       }else{
            responseResultArray = (response as! EventsResponse).events
           print("reponseArray.count : \(responseResultArray.count)")
            
            let formatter = DateFormatter()
            //2016-12-08 03:37:22 +0000
            formatter.dateFormat = "yyyy-MM-dd"
            let now = Date()
            let dateString = formatter.string(from:now)
            print("Date today is: \(dateString)")
            
//            guard let date1 = dateString1.toDate() else {
//                       print("dateString1: \(dateString1) | Failed to cast to \"dd/MM/yyyy  hh:mm\"")
//                       return
//                   }
            responseResultArray.forEach { i in
            guard let eventDate = i.dateEvent?.toDate()
                else{
                    print("Failed to convert")
                    return
                }
                if eventDate >= now{
                    upcomingEventsArray.append(i)
                }
                //if eventDate < now
                else
                {
                    latestEventsArray.append(i)
                }
                //compare and put into array
            }
            print("upcoming array is: \(upcomingEventsArray)")
            print("latest array is: \(latestEventsArray)")
            //}
            self.latestEventsCollection.reloadData()
    }
    
    func renderTeamsCollectionViewFromNetwork(response : Any, isCountriesEqualNull : Bool){
        let allTeams = (response as! TeamsResponse).teams
        for team in allTeams{
            if(team.idLeague == league.idLeague){
                teamsArray.append(team)
            }
        }
        print("all teams ReponseArray.count : \(allTeams.count)")
        print("league teams ReponseArray.count : \(teamsArray.count)")
        teamsCollection.reloadData()
    }
}

extension String {
    func toDate() -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.date(from: self)
    }
}


extension LeaguesDetailsViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch collectionView {
               case leaguesDetailsCollection:
                if upcomingEventsArray.count != 0 {
                    print("inside if, there is upcoming events")
                    //let the image be hidden
                    //"no upcoming events"
                    //noUpcomingEvents.image = UIImage(named: "no upcoming events")
                    noUpcomingEvents.isHidden = true
                    return upcomingEventsArray.count
                }
                else{
                    print("inside else, there is no upcoming events")

                   // let the image be unhidden
                    noUpcomingEvents.image = UIImage(named: "no-upcoming-events ")
                    noUpcomingEvents.isHidden = false
                      }
               case latestEventsCollection:
                   return latestEventsArray.count
               case teamsCollection:
                    return teamsArray.count
               default:
                   return 6
               }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView {
        case leaguesDetailsCollection:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! LeaguesDetailsCollectionViewCell
            
            if upcomingEventsArray.count != 0{
                //let the image be unhidden
                noUpcomingEvents.isHidden = true
                let strTime = upcomingEventsArray[indexPath.row].strTime ?? ""
                if(strTime != ""){
                    let timeArr = strTime.split(separator: ":")
                    cell.leagueTime.text = "\(timeArr[0]):\(timeArr[1])"
                }
                cell.leagueDate.text = upcomingEventsArray[indexPath.row].dateEvent
                
                 let ImageURL = URL(string: upcomingEventsArray[indexPath.row].strThumb ?? "")
                
                cell.eventImg.kf.setImage(with: ImageURL)

            }
            else{
                //no upcoming events found
                print("no upcoming events found")
                noUpcomingEvents.image = UIImage(named: "no-upcoming-events ")

                //let the image be unhidden
                noUpcomingEvents.isHidden = false
            }
                
            cell.contentView.layer.cornerRadius = 15.0
            
            // to make image  darker
//            let gradientLayer = CAGradientLayer()
//
//            gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
//            cell.eventImg.layer.addSublayer(gradientLayer)

            //cell.contentView.backgroundColor = UIColor.lightGray

            // cell corner
            cell.clipsToBounds = true
            cell.layer.cornerRadius = 25
                                      
            return cell
            
        case latestEventsCollection:
            let cell2 = collectionView.dequeueReusableCell(withReuseIdentifier: "cell2", for: indexPath) as! LatestEventsCollectionViewCell
            if(latestEventsArray[indexPath.row].intHomeScore ?? "" != ""){
                cell2.score.text = "\(latestEventsArray[indexPath.row].intHomeScore ?? "") - \(latestEventsArray[indexPath.row].intAwayScore ?? "")"
            }
            let strTime = latestEventsArray[indexPath.row].strTime ?? ""
            if(strTime != ""){
                let timeArr = strTime.split(separator: ":")
                cell2.time.text = "\(timeArr[0]):\(timeArr[1])"
            }
            
            cell2.date.text = latestEventsArray[indexPath.row].dateEvent
                           
       let ImageURL = URL(string: latestEventsArray[indexPath.row].strThumb ?? "")
                           
       cell2.eventImg.kf.setImage(with: ImageURL)
            
            cell2.contentView.layer.cornerRadius = 15.0
                     
                     // to make image  darker
        let gradientLayer = CAGradientLayer()
                     
    gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
    cell2.eventImg.layer.addSublayer(gradientLayer)
        cell2.contentView.backgroundColor = UIColor.lightGray
                     
     // cell corner
      cell2.clipsToBounds = true
      cell2.layer.cornerRadius = 25
      return cell2
            
    case teamsCollection:
        print("We are in drawing team cells")
        let cell3 = collectionView.dequeueReusableCell(withReuseIdentifier: "cell3", for: indexPath) as! TeamsCollectionViewCell
                                 
        cell3.teamName.text = teamsArray[indexPath.row].strTeam
            let imageURL = URL(string: teamsArray[indexPath.row].strTeamBadge ?? "")
        cell3.teamImg.kf.setImage(with: imageURL)
        //  cell UI (corner radius for image and cell/layer, background color)
        cell3.teamImg.layer.cornerRadius =      cell3.teamImg.frame.size.width/2
        cell3.teamImg.clipsToBounds = true
        cell3.teamImg.backgroundColor = UIColor.white
        cell3.layer.cornerRadius = 15
        cell3.layer.borderColor = UIColor.darkGray.cgColor
            
        return cell3
    default:
       return UICollectionViewCell()
    }
}
    
    func collectionView(_ collectionView: UICollectionView,
       layout collectionViewLayout: UICollectionViewLayout,
       sizeForItemAt indexPath: IndexPath) -> CGSize {
           
        let padding: CGFloat =  16
        let collectionViewSize = collectionView.frame.size.width - padding
        
        if (collectionView == leaguesDetailsCollection || collectionView == latestEventsCollection) {
            
                      return CGSize(width: collectionViewSize/1, height: 150)
        }
        
        return CGSize(width: collectionViewSize/3, height: 140)
          
       }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("inside prepare for segue in leagues\n")
        let teamsDetailsViewController : TeamsViewController = segue.destination as! TeamsViewController
        //  to get selected cell
        let cell = sender as! UICollectionViewCell
        let indexPath = self.teamsCollection!.indexPath(for: cell)
        teamsDetailsViewController.team = teamsArray[indexPath?.row ?? -1]
        teamsDetailsViewController.modalPresentationStyle = UIModalPresentationStyle.fullScreen
        
        self.present(teamsDetailsViewController, animated: true)
    }
   
}


