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
    //  saved leagues in coredata
    var coreDataLeagues : [CoreDataModel] = []
    //  country Name and Sport Name
    var sportName : String = ""

    //  assume by deafult we are in favourites screen
    var favLeagues : Bool = true
    
    @IBOutlet weak var sportLabel: UILabel!
    @IBOutlet weak var noLeaguesImage: UIImageView!
    @IBOutlet weak var leaguesCollection: UICollectionView!
    @IBOutlet weak var backButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //  collection view protocol conformation
        leaguesCollection.delegate = self
        leaguesCollection.dataSource = self
        
        //  set label text
        sportLabel.text = sportName
        
        //  variables initializations
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        // create refernce to entity/table
        let managedContext = appDelegate.persistentContainer.viewContext
        presenter = LeaguesPresenter(networkService: NetworkManager.delegate, localModel:CoreDataHandling(context: managedContext) , view: self)
        coreDataLeagues = presenter.fetchLeaguesFromCoreData()
        if(favLeagues){
            print("You are in favourite leagues tab")
            backButton.isHidden = true
            coreDataLeagues = presenter.fetchLeaguesFromCoreData()
            if(coreDataLeagues.count == 0){
                noLeaguesImage.isHidden = false
                print("No favourites")
            }else{
                noLeaguesImage.isHidden = true
                print("User has favourites")
            }
            
        }else{
            let parameters = [ "s":sportName]
            print("parameters: \(parameters)")
            presenter.getLeaguesListItems(urlID: 2, parameteres: parameters)
        }
        
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}


extension LeaguesViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //  successful request with array of response greater than 0
        if(responseResultArray.count != 0){
            noLeaguesImage.isHidden = true
            return responseResultArray.count
        }
        //  array of response equals  0
        if(responseResultArray.count == 0){
            if(favLeagues){
                //  User in favourites screen
                if(coreDataLeagues.count != 0){
                    //  if user has favourite leagues
                    return coreDataLeagues.count
                }else{
                    //  if there are no favourites
                    noLeaguesImage.image = UIImage(named: "noFavourites")
                }
            }else{
                //   successful request with array of response equals 0
                //noLeaguesImage.image = UIImage(named: "noLeagues")
            }
            noLeaguesImage.isHidden = false
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! LeaguesCollectionViewCell
        
        //pass youtube link to leagueCell class
        let leagueCell = LeaguesCollectionViewCell()
        
        if(responseResultArray.count != 0){
            //  if user online
            cell.leagueNameLabel.text = responseResultArray[indexPath.row].strLeague
            let imageURL = URL(string: responseResultArray[indexPath.row].strBadge ?? "")
            cell.leagugeImage.kf.setImage(with: imageURL)
            leagueCell.url = responseResultArray[indexPath.row].strYoutube ?? ""
        }else{
            //  if user offline ..
            if(coreDataLeagues.count != 0){
                cell.leagueNameLabel.text = coreDataLeagues[indexPath.row].strLeague
                let imageURL = URL(string: coreDataLeagues[indexPath.row].strBadge ?? "")
                cell.leagugeImage.kf.setImage(with: imageURL)
                leagueCell.url = coreDataLeagues[indexPath.row].strYoutube ?? ""
            }
        }

        //  cell UI (corner radius for image and cell/layer, background color)
        cell.leagugeImage.layer.cornerRadius = cell.leagugeImage.frame.size.width/2
        cell.leagugeImage.clipsToBounds = true
        cell.leagugeImage.backgroundColor = UIColor.white
        cell.layer.cornerRadius = 15
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let padding: CGFloat =  25
        let collectionViewSize = collectionView.frame.size.width - padding
        return CGSize(width: collectionViewSize/1, height: 70)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        print("inside prepare for segue in leagues\n")
        let leaguesDetailsViewController : LeaguesDetailsViewController = segue.destination as! LeaguesDetailsViewController
        //  to get selected cell
        let cell = sender as! UICollectionViewCell
        let indexPath = self.leaguesCollection!.indexPath(for: cell)

        if(responseResultArray.count != 0){
            leaguesDetailsViewController.league.idLeague = responseResultArray[indexPath?.row ?? -1].idLeague ?? ""
            leaguesDetailsViewController.league.strLeague = responseResultArray[indexPath?.row ?? -1].strLeague ?? ""
            leaguesDetailsViewController.league.strSport = responseResultArray[indexPath?.row ?? -1].strSport ?? ""
            leaguesDetailsViewController.league.strBadge = responseResultArray[indexPath?.row ?? -1].strBadge ?? ""
            leaguesDetailsViewController.league.strLogo = responseResultArray[indexPath?.row ?? -1].strLogo ?? ""
            leaguesDetailsViewController.league.strYoutube = responseResultArray[indexPath?.row ?? -1].strYoutube ?? ""
            leaguesDetailsViewController.league.strCountry = responseResultArray[indexPath?.row ?? -1].strCountry ?? ""
        }else{
            if(coreDataLeagues.count != 0){
                leaguesDetailsViewController.league.idLeague = coreDataLeagues[indexPath?.row ?? -1].idLeague ?? ""
                leaguesDetailsViewController.league.strLeague = coreDataLeagues[indexPath?.row ?? -1].strLeague ?? ""
                leaguesDetailsViewController.league.strSport = coreDataLeagues[indexPath?.row ?? -1].strSport ?? ""
                leaguesDetailsViewController.league.strBadge = coreDataLeagues[indexPath?.row ?? -1].strBadge ?? ""
                leaguesDetailsViewController.league.strLogo = coreDataLeagues[indexPath?.row ?? -1].strLogo ?? ""
                leaguesDetailsViewController.league.strYoutube = coreDataLeagues[indexPath?.row ?? -1].strYoutube ?? ""
                leaguesDetailsViewController.league.strCountry = coreDataLeagues[indexPath?.row ?? -1].strCountry ?? ""
            }
        }
        leaguesDetailsViewController.allLeaguesScreen = self
        leaguesDetailsViewController.modalPresentationStyle = UIModalPresentationStyle.fullScreen
        
        self.present(leaguesDetailsViewController, animated: true)
    }
    
}

extension LeaguesViewController : LeaguesViewControllerProtocol{
    func renderCollectionViewFromNetwork(response : Any ,isCountriesEqualNull : Bool){
        if(isCountriesEqualNull){
            _ = (response as! NullReponse)
            responseResultArray = []
        }else{
            responseResultArray = (response as! LeaguesResponse).countries
            print("reponseArray.count : \(responseResultArray.count)")
            print("youtube link is : \(responseResultArray[1].strYoutube)")
            
        }
        self.leaguesCollection.reloadData()
    }
    
    func reloadCollectionView(){
        if(favLeagues){
            print("You are in favourite leagues tab")
            coreDataLeagues = presenter.fetchLeaguesFromCoreData()
            if(coreDataLeagues.count == 0){
                noLeaguesImage.isHidden = false
                print("No favourites")
            }else{
                noLeaguesImage.isHidden = true
                print("User has favourites: \(coreDataLeagues.count)")
            }
        }else{
            let parameters = [ "s":sportName]
            print("parameters: \(parameters)")
            presenter.getLeaguesListItems(urlID: 2, parameteres: parameters)
        }
        self.leaguesCollection.reloadData()
    }
}

