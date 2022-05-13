//
//  SportsPresenter.swift
//  SportsApplication
//
//  Created by nihal yasser khamis on 5/11/22.
//  Copyright © 2022 iti. All rights reserved.
//

import Foundation

class SportsPresenter : SportsPresenterProtocol{
    var networkManager : NetworkManagerProtocol!
    var responseResult : Any!
    weak var view : SportsViewControllerProtocol!
    
    init(networkService : NetworkManager, view : SportsViewControllerProtocol){
        networkManager = networkService
        self.view = view
    }
    
    func getSportsListItems(urlID : Int){
        networkManager.fetchSportsList(urlID: urlID){[weak self] (result,error)  in
            guard result != nil else{
                print("From All sports presenter: Response = nil")
                return
            }
            //self?.responseResult = result
            self?.view.renderCollectionViewFromNetwork(response: result!)
        }
    }
}
