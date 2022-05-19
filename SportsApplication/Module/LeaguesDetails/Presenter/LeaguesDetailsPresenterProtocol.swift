//
//  LeaguesDetailsPresenterProtocol.swift
//  SportsApplication
//
//  Created by nihal yasser khamis on 5/15/22.
//  Copyright © 2022 iti. All rights reserved.
//

import Foundation

protocol LeaguesDetailsPresenterProtocol {
    func saveLeagueInCoreData(league: CoreDataModel)
    func deleteLeagueFromCoreData(league: CoreDataModel)
    func fetchLeaguesFromCoreData() -> [CoreDataModel]
}
