//
//  CoreDataHandlingProtocol.swift
//  SportsApplication
//
//  Created by Esraa Lotfy  on 5/18/22.
//  Copyright © 2022 iti. All rights reserved.
//

import Foundation

protocol CoreDataHandlingProtocol {
    func fetchUpdatedData() -> Array<CoreDataModel>
    func saveData(league: CoreDataModel)
    func deleteData(league: CoreDataModel)
}
