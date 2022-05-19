//
//  LeaguesDetailsPresenter.swift
//  SportsApplication
//
//  Created by nihal yasser khamis on 5/15/22.
//  Copyright © 2022 iti. All rights reserved.
//

import Foundation

class LeaguesDetailsPresenter {
    var networkDelegate : NetworkManagerProtocol!
    var localModel : CoreDataHandlingProtocol!
    weak var view : LeaguesDetailsViewControllerProtocol!
    
    init(networkDelegate : NetworkManagerProtocol, localModel: CoreDataHandlingProtocol, view : LeaguesDetailsViewControllerProtocol) {
        self.networkDelegate = networkDelegate
        self.localModel = localModel
        self.view = view
        print("we are leaguesDetailsPresenter init")
        /*guard let NWdelegate = self.networkDelegate else{
            return
        }
        self.networkDelegate = NWdelegate
        guard let locModel = self.localModel else{
            return
        }
        self.localModel = locModel*/
    }
}

extension LeaguesDetailsPresenter : LeaguesDetailsPresenterProtocol{
    func getLeaguesDetailsListItems(urlID: Int, parameteres: [String : String]) {
        networkDelegate.fetchLists(urlID: urlID, paramerters: parameteres){[weak self] (result,error,isCountriesEqualNull)  in
                   guard result != nil else{
                       print("From leagues details presenter: Response = nil")
                       return
                   }
                   self?.view.renderCollectionViewFromNetwork(response: result!, isCountriesEqualNull: isCountriesEqualNull)
               }
        
    }
    
    func saveLeagueInCoreData(league: CoreDataModel){
        self.localModel.saveData(league: league)
    }
    
    func deleteLeagueFromCoreData(league: CoreDataModel){
        self.localModel.deleteData(league: league)
    }
    
    func fetchLeaguesFromCoreData() -> [CoreDataModel]{
        self.localModel.fetchUpdatedData()
    }
}
