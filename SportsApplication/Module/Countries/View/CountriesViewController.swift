//
//  CountriesViewController.swift
//  SportsApplication
//
//  Created by nihal yasser khamis on 5/13/22.
//  Copyright © 2022 iti. All rights reserved.
//

import UIKit

class CountriesViewController: UIViewController {

    @IBOutlet weak var countriesCollection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("inside countries")

        self.countriesCollection.delegate = self
        self.countriesCollection.dataSource = self
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension CountriesViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 6
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CountryCollectionViewCell
        
        cell.countryName.text = "Egypt"
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
                  return CGSize(width: collectionViewSize, height: 100)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
        
    }
    
    
}
