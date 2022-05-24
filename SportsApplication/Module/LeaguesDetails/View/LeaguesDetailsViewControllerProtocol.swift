//
//  LeaguesDetailsViewControllerProtocol.swift
//  SportsApplication
//
//  Created by Esraa Lotfy  on 5/19/22.
//  Copyright © 2022 iti. All rights reserved.
//

import Foundation

protocol LeaguesDetailsViewControllerProtocol : AnyObject{
    func renderCollectionViewFromNetwork(response : Any, error : Bool ,isCountriesEqualNull : Bool)
    //  for teams network response
    func renderTeamsCollectionViewFromNetwork(response : Any, isCountriesEqualNull : Bool)
}
