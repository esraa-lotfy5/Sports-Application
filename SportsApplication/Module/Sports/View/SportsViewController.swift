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
    var presenter : SportsPresenterProtocol!
    //  response result array from network
    var responseResultArray  : [Sport] = []
    
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
    }
}


extension SportsViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(responseResultArray.count != 0){
            print("Array Count : \(responseResultArray.count)")
            return responseResultArray.count
        }
        return 0
       }
       
   func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        
        let imageURL = URL(string: responseResultArray[indexPath.row].strSportThumb ?? "")
        cell.sportThumb.kf.setImage(with: imageURL)
        cell.sportName.text = responseResultArray[indexPath.row].strSport
    
        cell.sportName.textColor = UIColor.black
        
        cell.contentView.layer.cornerRadius = 15.0
        cell.contentView.layer.borderWidth = 1.0
        cell.contentView.layer.borderColor = UIColor.black.cgColor
        
                return cell
       }
    
    func collectionView(_ collectionView: UICollectionView,
                           layout collectionViewLayout: UICollectionViewLayout,
                           sizeForItemAt indexPath: IndexPath) -> CGSize {
         
           let padding: CGFloat =  25
           let collectionViewSize = collectionView.frame.size.width - padding
           return CGSize(width: collectionViewSize/2, height: 115)
           
       }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print(responseResultArray[indexPath.row].strSport ?? "no name")
        

        let countriesViewController : CountriesViewController = self.storyboard?.instantiateViewController(withIdentifier: "go_to_countries") as! CountriesViewController
        
        countriesViewController.modalPresentationStyle = UIModalPresentationStyle.fullScreen
        
        self.navigationController?.pushViewController(countriesViewController, animated: true)
        
        
    }
    
}


extension SportsViewController : SportsViewControllerProtocol{
    func renderCollectionViewFromNetwork(response : Any){
        responseResultArray = (response as! SportsResponse).sports
        print("Sport Name: \(responseResultArray[0].strSport ?? "No Sport Name")")
        self.sportsCollection.reloadData()
    }
}
