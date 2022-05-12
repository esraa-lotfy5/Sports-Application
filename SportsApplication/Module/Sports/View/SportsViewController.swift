//
//  SportsViewController.swift
//  SportsApplication
//
//  Created by Esraa Lotfy  on 5/11/22.
//  Copyright © 2022 iti. All rights reserved.
//

import UIKit

class SportsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var sportsCollection: UICollectionView!
    
    let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.sportsCollection.delegate = self
        self.sportsCollection.dataSource = self
        
         layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        
        sportsCollection!.collectionViewLayout = layout
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return 6
       }
       
       func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        
        cell.sportThumb.image = UIImage(named: "sports-2.png")
        cell.sportName.text = "Soccer"
        cell.sportName.textColor = UIColor.white
        
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
}

