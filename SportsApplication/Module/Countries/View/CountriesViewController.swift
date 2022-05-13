//
//  CountriesViewController.swift
//  SportsApplication
//
//  Created by nihal yasser khamis on 5/13/22.
//  Copyright © 2022 iti. All rights reserved.
//

import UIKit

class CountriesViewController: UIViewController {
    
    //  object of presenter
       var presenter : CountriesPresenterProtocol!
       //  response result array from network
       var responseResultArray  : [Country] = []

    @IBOutlet weak var countriesCollection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("inside countries")

        self.countriesCollection.delegate = self
        self.countriesCollection.dataSource = self
        
        //  variables initializations
        presenter = CountriesPresenter(networkService: NetworkManager.delegate, view: self)
        presenter.getCountriesListItems(urlID: 1)
        
    }
    
}

extension CountriesViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if(responseResultArray.count != 0){
            print("Country Array Count : \(responseResultArray.count)")
            return responseResultArray.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CountryCollectionViewCell
        
        cell.countryName.text = responseResultArray[indexPath.row].name_en
        cell.countryName.textColor = UIColor.black
        
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
                  return CGSize(width: collectionViewSize/1, height: 100)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print(responseResultArray[indexPath.row].name_en ?? "no name")
        
    }
}

extension CountriesViewController : CountriesViewControllerProtocol{
    func renderCountriesCollectionViewFromNetwork(response : Any){
        responseResultArray = (response as! CountriesResponse).countries
        print("Country Name: \(responseResultArray[0].name_en ?? "No country Name")")
        self.countriesCollection.reloadData()
    }
}
