//
//  NetwokManager.swift
//  SportsApplication
//
//  Created by Esraa Lotfy  on 5/13/22.
//  Copyright © 2022 iti. All rights reserved.
//

import Foundation
import Alamofire

class NetworkManager : NetworkManagerProtocol{
    private init(){}
    static let delegate = NetworkManager()
    // urls[0]: all sports url
    // urls[1]: all countries -> unused anymore
    // urls[2]: all leagues
    // urls[3]: all teams ->  s=Soccer&c=Spain"
    let urls = [
        "https://www.thesportsdb.com/api/v1/json/2/all_sports.php",
        "https://www.thesportsdb.com/api/v1/json/2/all_countries.php",
        "https://www.thesportsdb.com/api/v1/json/2/search_all_leagues.php?",
        "https://www.thesportsdb.com/api/v1/json/2/search_all_teams.php?",
        "https://www.thesportsdb.com/api/v1/json/2/eventsseason.php?id=4328"
        ]

    //  for fetching -> AllSportsList, AllCountriesList, LeaguesList
    func fetchLists(urlID :Int , paramerters: [String : String], complitionHandler: @escaping (Any?, Error?, Bool) -> Void){
        
        Alamofire.request(urls[urlID], parameters: paramerters).responseJSON{ response in
            //  if error occured
            if response.error != nil{
                print("Error in fetching sports list : \(response.error!)")
                complitionHandler(nil, response.error, false)
            }
            guard let data = response.data else{
                print("NO DATA from fetching sports list")
                return
            }
            do{
                let decoder = JSONDecoder()
                //  switch on urlID to decode to the right format
                switch(urlID){
                case 0:
                    let info = try decoder.decode(SportsResponse.self, from: data)
                    complitionHandler(info, nil,false)
                    //print("Data from fetching sports list : \n \(info)")
                    break
                case 2:
                    let info = try decoder.decode(LeaguesResponse.self, from: data)
                   // print("\n  \n info : \(info) \n \n")
                    complitionHandler(info, nil, false)
                case 3:
                    let info = try decoder.decode(TeamsResponse.self, from: data)
                    complitionHandler(info, nil, false)
                case 4:
                    let info = try decoder.decode(EventsResponse.self, from: data)
                    print("\n Events Response:\(info.events.count)")
                    complitionHandler(info, nil, false)
                default:
                    print("request url not true")
                    break
                }
                
            } catch {
                do{
                let decoder = JSONDecoder()
                let info = try decoder.decode(NullReponse.self, from: data)
                // countries = null
                complitionHandler(info, nil, true)
            }catch{
                print("Response : \(data)")
                print("Error : \(error)")
            }
        }
        }
    }
}
