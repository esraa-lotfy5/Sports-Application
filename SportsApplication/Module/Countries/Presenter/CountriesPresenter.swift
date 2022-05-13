//
//  CountriesPresenter.swift
//  SportsApplication
//
//  Created by nihal yasser khamis on 5/13/22.
//  Copyright © 2022 iti. All rights reserved.
//

import Foundation

class CountriesPresenter : CountriesPresenterProtocol{
    var networkManager : NetworkManagerProtocol!
    weak var view : CountriesViewControllerProtocol!
    
    init(networkService : NetworkManager, view : CountriesViewControllerProtocol){
        networkManager = networkService
        self.view = view
    }
    
    func getCountriesListItems(urlID: Int) {
        
        networkManager.fetchSportsList(urlID: urlID){[weak self] (result,error)  in
            guard result != nil else{
                print("From All countries presenter: Response = nil")
                return
            }
            self?.view.renderCountriesCollectionViewFromNetwork(response: result!)
        }
    }
}
