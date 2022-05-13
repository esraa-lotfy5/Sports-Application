//
//  NetworkManagerProtocol.swift
//  SportsApplication
//
//  Created by Esraa Lotfy  on 5/13/22.
//  Copyright © 2022 iti. All rights reserved.
//

import Foundation

protocol NetworkManagerProtocol{
    func fetchLists(urlID :Int, paramerters: [String : String], complitionHandler: @escaping (Any?, Error?) -> Void)
}
