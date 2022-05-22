//
//  CoreDataHandling.swift
//  SportsApplication
//
//  Created by Esraa Lotfy  on 5/19/22.
//  Copyright © 2022 iti. All rights reserved.
//

import Foundation
import CoreData

class CoreDataHandling : CoreDataHandlingProtocol{
    var managedContext : NSManagedObjectContext!
    
    init(context: NSManagedObjectContext) {
        managedContext = context
    }
    
    func fetchUpdatedData() -> Array<CoreDataModel> {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "FavLeague")
        var leagues : [CoreDataModel] = []
        do{
            //  fetch Array<NSManagedObject>
            let leaguesNSManagedObject = try managedContext.fetch(fetchRequest)
            //  if coredata is empty and no element is saved
            if leaguesNSManagedObject.count == 0 {
                return []
            }
            //  if coredata has elements, put them in Array<CoreDataModel>
            for i in 0...leaguesNSManagedObject.count-1 {
                let league = CoreDataModel()
                league.idLeague = (leaguesNSManagedObject[i].value(forKey: "idLeague") as! String)
                league.strLeague = (leaguesNSManagedObject[i].value(forKey: "strLeague") as! String)
                league.strSport = (leaguesNSManagedObject[i].value(forKey: "strSport") as! String)
                league.strBadge = (leaguesNSManagedObject[i].value(forKey: "strBadge") as! String)
                league.strLogo = (leaguesNSManagedObject[i].value(forKey: "strLogo") as! String)
                league.strYoutube = (leaguesNSManagedObject[i].value(forKey: "strYoutube") as! String)
                league.strCountry = (leaguesNSManagedObject[i].value(forKey: "strCountry") as! String)
                leagues.append(league)
            }
            print("leagues.count : \(leagues.count)")
            return leagues
        }catch let error{
            print("Error Ocurred while fetching data from core data \n")
            print("Error: \(error.localizedDescription)")
        }
        print("empty leagues")
        return leagues
    }
    
    func saveData(league: CoreDataModel) {
        let entity = NSEntityDescription.entity(forEntityName: "FavLeague", in: managedContext)
        // create managed object
        let copiedLeagues = NSManagedObject(entity: entity!, insertInto: managedContext)
        copiedLeagues.setValue(league.idLeague , forKey: "idLeague")
        copiedLeagues.setValue(league.strLeague , forKey: "strLeague")
        copiedLeagues.setValue(league.strSport , forKey: "strSport")
        copiedLeagues.setValue(league.strBadge , forKey: "strBadge")
        copiedLeagues.setValue(league.strLogo , forKey: "strLogo")
        copiedLeagues.setValue(league.strYoutube , forKey: "strYoutube")
        copiedLeagues.setValue(league.strCountry , forKey: "strCountry")
        do{
            try managedContext.save()
            print("Successfully inserted")
        }catch let error{
            print("Error Occured while saving new movie \n")
            print("Error: \(error.localizedDescription)")
        }
    }
    
    func deleteData(league: CoreDataModel){
        //  convert league to NSmanagedObject
        let fetchRequest = NSFetchRequest<NSManagedObject> (entityName: "FavLeague")
        fetchRequest.predicate = NSPredicate.init(format : "idLeague = \(league.idLeague!)")
        do{
            let objects = try managedContext.fetch(fetchRequest)
            for object in objects {
                managedContext.delete(object)
            }
            try managedContext.save()
            print("Successfully deleted")
        }catch let error{
            print("Error Ocurred while deleting movie \n")
            print("Error : \(error.localizedDescription)")
        }
    }
}
