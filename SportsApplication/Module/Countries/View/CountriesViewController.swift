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
    //  sport name
    var sportNameInCountryViewController : String = ""
    //  selected country name
    var selectedCountryName : String = ""

    @IBOutlet weak var countriesCollection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
            print("From CountriesViewController: Country Array Count : \(responseResultArray.count)")
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        let leaguesViewController : LeaguesViewController = segue.destination as! LeaguesViewController
        //  to get selected cell
        let cell = sender as! UICollectionViewCell
        let indexPath = self.countriesCollection!.indexPath(for: cell)
        leaguesViewController.sportName = sportNameInCountryViewController
        leaguesViewController.countryName = responseResultArray[indexPath?.row ?? -1].name_en ?? ""
        leaguesViewController.modalPresentationStyle = UIModalPresentationStyle.fullScreen
    }
}

extension CountriesViewController : CountriesViewControllerProtocol{
    func renderCountriesCollectionViewFromNetwork(response : Any){
        responseResultArray = (response as! CountriesResponse).countries
        self.countriesCollection.reloadData()
    }
}
