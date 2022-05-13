//
//  LeaguesPresenter.swift
//  SportsApplication
//
//  Created by Esraa Lotfy  on 5/13/22.
//  Copyright © 2022 iti. All rights reserved.
//

import Foundation

class LeaguesPresenter : LeaguesPresenterProtocol{
    var networkManager : NetworkManagerProtocol!
    var responseResult : Any!
    weak var view : LeaguesViewControllerProtocol!
    
    init(networkService : NetworkManager, view : LeaguesViewControllerProtocol){
        networkManager = networkService
        self.view = view
    }
    
    func getSportsListItems(urlID : Int, parameteres: [String : String]){
        networkManager.fetchLists(urlID: urlID, paramerters: parameteres){[weak self] (result,error)  in
            guard result != nil else{
                print("From All leagues presenter: Response = nil")
                return
            }
            self?.view.renderCollectionViewFromNetwork(response: result!)
        }
    }
}
