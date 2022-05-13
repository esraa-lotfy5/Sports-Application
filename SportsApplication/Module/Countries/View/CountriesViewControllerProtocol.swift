//
//  CountriesViewControllerProtocol.swift
//  SportsApplication
//
//  Created by nihal yasser khamis on 5/13/22.
//  Copyright © 2022 iti. All rights reserved.
//

import Foundation

protocol CountriesViewControllerProtocol : AnyObject{
    func renderCountriesCollectionViewFromNetwork(response : Any)
}