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
    let urls = [
        "https://www.thesportsdb.com/api/v1/json/2/all_sports.php",
        "https://www.thesportsdb.com/api/v1/json/2/all_countries.php"
    ]
    
    func fetchSportsList(urlID :Int , complitionHandler: @escaping (Any?, Error?) -> Void){
        Alamofire.request(urls[urlID]).responseJSON{ response in
            //  if error occured
            if response.error != nil{
                print("Error in fetching sports list : \(response.error!)")
                complitionHandler(nil, response.error)
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
                    complitionHandler(info, nil)
                    print("Data from fetching sports list : \n \(info)")
                    break
                case 1:
                    let info = try decoder.decode(CountriesResponse.self, from: data)
                    complitionHandler(info, nil)
                    print("Data from fetching countries list : \n \(info)")
                    break
                default:
                    print("request url not true")
                    break
                }
                
            } catch {
                print("Error : \(error)")
            }
            debugPrint(response)}
    }
}
