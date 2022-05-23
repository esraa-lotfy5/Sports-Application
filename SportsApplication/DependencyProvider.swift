//
//  DependencyProvider.swift
//  SportsApplication
//
//  Created by Esraa Lotfy  on 5/23/22.
//  Copyright © 2022 iti. All rights reserved.
//

import Foundation
import UIKit

class DependencyProvider{

    /*static var networkDelegate : NetworkManagerProtocol{
        return NetworkManager.delegate
    }
    
    static var localModel : CoreDataHandlingProtocol{
        // for core data
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        return CoreDataHandling(context : managedContext)
    }
    
    static var sportsViewController : SportsViewController{
        let sportsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "allSports") as! SportsViewController
        sportsVC.sportsPresenter = sportsPresenter
        return SportsViewController()
    }
    
    static var sportsPresenter : SportsPresenterProtocol{
        return SportsPresenter(networkService: self.networkDelegate as! NetworkManager, view: self.sportsViewController)
    }*/
    
    //static var sportsPresenter : SportsPresenterProtocol{
       // return SportsPresenter(networkService: self.networkDelegate, view: )
    //}
    //static var movieDetailsViewModel : MovieDetailsViewModel{
    //    return MovieDetailsViewModel()
    //}
}
