//
//  SportsViewController.swift
//  SportsApplication
//
//  Created by Esraa Lotfy  on 5/11/22.
//  Copyright © 2022 iti. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher

class SportsViewController: UIViewController{
    //  object of presenter
    //var homeViewModel : HomeViewModel!
    var presenter : SportsPresenterProtocol!
    //  response result array from network
    var responseResultArray  : [Sport] = []
    //  selected Sport Name
    var selectedSportName : String = ""
    //  collection view style : by default -> one item in row
    var isList : Bool = true    // false -> grid view
    //  for sub layer of collection view image
    var firstSportsCollectionReload : Bool = true
    var listBounds : CGRect = CGRect()
    
    @IBOutlet weak var collectionViewStyleImage: UIButton!
    
    @IBOutlet weak var sportsCollection: UICollectionView!
    
    let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        //  collection view conforming protocols
        self.sportsCollection.delegate = self
        self.sportsCollection.dataSource = self
        
        //  collection view (UI)
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)    //  margin
        sportsCollection!.collectionViewLayout = layout
        
        //  variables initializations
    presenter = SportsPresenter(networkService: NetworkManager.delegate, view: self)
        presenter.getSportsListItems(urlID: 0)
        
        //
    }
    
    @IBAction func changeCollectionViewStyle(_ sender: UIButton) {
        if (isList){
            collectionViewStyleImage.setImage(UIImage(systemName: "list.bullet"), for: .normal)
            isList = false
            sportsCollection.reloadData()
        }else{
            collectionViewStyleImage.setImage(UIImage(systemName: "square.grid.2x2"), for: .normal)
            isList = true
            sportsCollection.reloadData()
        }
    }
}


extension SportsViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(responseResultArray.count != 0){
            print("From SportsViewController: Array Count : \(responseResultArray.count)")
            return responseResultArray.count
        }
        return 0
       }
       
   func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        //  setting sport image
        let imageURL = URL(string: responseResultArray[indexPath.row].strSportThumb ?? "")
        cell.sportThumb.kf.setImage(with: imageURL)
        //if(indexPath.row > 0){
        
        if(firstSportsCollectionReload){
            listBounds = cell.sportThumb.bounds
            firstSportsCollectionReload = false
        }
        //  to remove any sublayer existed
        cell.sportThumb.layer.sublayers?.forEach{$0.removeFromSuperlayer()}
        // to make image  darker
        let gradientLayer = CAGradientLayer()
        if(isList){
            gradientLayer.frame = listBounds
        }else{
            gradientLayer.frame = cell.sportThumb.frame
        }
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        cell.sportThumb.layer.addSublayer(gradientLayer)
        
        //  setting sport name
        cell.sportName.text = responseResultArray[indexPath.row].strSport
        //  cell corner radius
        cell.contentView.layer.cornerRadius = 15.0
    
        return cell
       }
    
    func collectionView(_ collectionView: UICollectionView,
                           layout collectionViewLayout: UICollectionViewLayout,
                           sizeForItemAt indexPath: IndexPath) -> CGSize {
        //print("we are here")
        let padding: CGFloat =  25
        let collectionViewSize = collectionView.frame.size.width - padding
        if(isList){
            return CGSize(width: collectionViewSize/1, height: 115)
        }
        return CGSize(width: collectionViewSize/2, height: 115)
   }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let leaguesViewController : LeaguesViewController = segue.destination as! LeaguesViewController
        //  to get selected cell
        let cell = sender as! UICollectionViewCell
        let indexPath = self.sportsCollection!.indexPath(for: cell)
        leaguesViewController.sportName = responseResultArray[indexPath?.row ?? -1].strSport ?? ""
        leaguesViewController.favLeagues = false
        leaguesViewController.modalPresentationStyle = UIModalPresentationStyle.fullScreen
        
        self.present(leaguesViewController, animated: true)
    }
}


extension SportsViewController : SportsViewControllerProtocol{
    func renderCollectionViewFromNetwork(response : Any){
        responseResultArray = (response as! SportsResponse).sports
        self.sportsCollection.reloadData()
    }
}
