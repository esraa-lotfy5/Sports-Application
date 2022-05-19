//
//  LeaguesPresenterProtocol.swift
//  SportsApplication
//
//  Created by Esraa Lotfy  on 5/13/22.
//  Copyright © 2022 iti. All rights reserved.
//

import Foundation

protocol LeaguesPresenterProtocol {
    func getLeaguesListItems(urlID : Int, parameteres: [String : String])
    func deleteLeagueFromCoreData(league: CoreDataModel)
    func fetchLeaguesFromCoreData() -> [CoreDataModel]
}
