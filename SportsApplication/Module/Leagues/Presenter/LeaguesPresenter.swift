//
//  LeaguesPresenter.swift
//  SportsApplication
//
//  Created by Esraa Lotfy  on 5/13/22.
//  Copyright © 2022 iti. All rights reserved.
//

import Foundation

class LeaguesPresenter {
    var networkManager : NetworkManagerProtocol!
    var localModel : CoreDataHandlingProtocol!
    var responseResult : Any!
    weak var view : LeaguesViewControllerProtocol!
    
    init(networkService : NetworkManager, localModel: CoreDataHandlingProtocol, view : LeaguesViewControllerProtocol){
        networkManager = networkService
        self.localModel = localModel
        self.view = view
    }
}


extension LeaguesPresenter : LeaguesPresenterProtocol{
    
    func getLeaguesListItems(urlID : Int, parameteres: [String : String]){
        networkManager.fetchLists(urlID: urlID, paramerters: parameteres){[weak self] (result,error,isCountriesEqualNull)  in
            guard result != nil else{
                print("From All leagues presenter: Response = nil")
                return
            }
            self?.view.renderCollectionViewFromNetwork(response: result!, isCountriesEqualNull: isCountriesEqualNull)
        }
    }
    
    func deleteLeagueFromCoreData(league: CoreDataModel){
        self.localModel.deleteData(league: league)
    }
    
    func fetchLeaguesFromCoreData() -> [CoreDataModel]{
        self.localModel.fetchUpdatedData()
    }
}
