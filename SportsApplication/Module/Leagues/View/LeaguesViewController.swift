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
    //var countryName : String = ""
    
    var favLeagues : Bool = true
    
    @IBOutlet weak var sportLabel: UILabel!
    @IBOutlet weak var noLeaguesImage: UIImageView!
    @IBOutlet weak var leaguesCollection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //  collection view protocol conformation
        leaguesCollection.delegate = self
        leaguesCollection.dataSource = self
        
        //  set label text
        sportLabel.text = sportName
        
        //  variables initializations
        presenter = LeaguesPresenter(networkService: NetworkManager.delegate, view: self)
        if(favLeagues){
            print("You are in favourite leagues tab")
            noLeaguesImage.isHidden = false
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
        
        if(responseResultArray.count != 0){
            print("From LeaguesViewController: Leagues Array Count : \(responseResultArray.count)")
            noLeaguesImage.isHidden = true
            return responseResultArray.count
        }
        if(responseResultArray.count == 0){
            print("response array length = 0")
            if(favLeagues){
                noLeaguesImage.image = UIImage(named: "noFavourites")
            }else{
                noLeaguesImage.image = UIImage(named: "noLeagues")
            }
            
            noLeaguesImage.isHidden = false
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! LeaguesCollectionViewCell
        
        //pass youtube link to leagueCell class
        let leagueCell = LeaguesCollectionViewCell()
        leagueCell.url = responseResultArray[indexPath.row].strYoutube ?? ""
        
        cell.leagueNameLabel.text = responseResultArray[indexPath.row].strLeague
        let imageURL = URL(string: responseResultArray[indexPath.row].strBadge ?? "")
        cell.leagugeImage.kf.setImage(with: imageURL)
        //cell.leagugeImage.layer.borderWidth = 1
        //cell.leagugeImage.layer.masksToBounds = false
        cell.leagugeImage.layer.cornerRadius = cell.leagugeImage.frame.size.width/2
        //cell.leagugeImage.layer.borderColor = UIColor.black.cgColor
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
        leaguesDetailsViewController.sportName = sportName
        //        leaguesViewController.countryName = responseResultArray[indexPath?.row ?? -1].name_en ?? ""
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
}

