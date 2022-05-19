//
//  MockingNetworkManagerTests.swift
//  SportsApplicationTests
//
//  Created by Esraa Lotfy  on 5/13/22.
//  Copyright © 2022 iti. All rights reserved.
//

import XCTest
@testable import SportsApplication

class MockingNetworkManagerTests: XCTestCase {
    let mockObject = MockNetworkManager(shouldReturnError: false)
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    //test for all sports list
    func testFetchSportsList(){
        mockObject.fetchLists(urlID: 0, paramerters: [:]) { (sports, error, isNull) in
            guard let sports = (sports as? SportsResponse)?.sports else{
                XCTFail()
                return
            }
            XCTAssertEqual(sports.count, 34, "API failed") //true: 43
        }
    }
    
    //test for all countries list
    func testFetchCountriesList(){
        mockObject.fetchLists(urlID: 1, paramerters: [:]) { (countries, error, isNull) in
            guard let countries = (countries as? CountriesResponse)?.countries else{
                XCTFail()
                return
            }
            XCTAssertEqual(countries.count, 257, "API failed") //true: 257
        }
    }
    
    //test for all leagues list
   func testFetchLeaguesList(){
    mockObject.fetchLists(urlID: 2, paramerters: ["s":"Soccer"]) { (leagues, error, isNull) in
           guard let leagues = (leagues as? LeaguesResponse)?.countries else{
               XCTFail()
               return
           }
        print("leagues.count = \(leagues.count)")
           XCTAssertEqual(leagues.count, 150, "API failed") //true: 10
       }
   }
    
    //test for all teams list
      func testFetchTeamsList(){
       mockObject.fetchLists(urlID: 3, paramerters: ["s":"Soccer" , "c":"England"]) { (teams, error, isNull) in
              guard let teams = (teams as? TeamsResponse)?.teams else{
                  XCTFail()
                  return
              }
           print("teams.count = \(teams.count)")
              XCTAssertEqual(teams.count, 4, "API failed") //true: 10
          }
      }
    
    //test for all events list
    func testFetchEventsList(){
        mockObject.fetchLists(urlID: 4, paramerters: ["id":"4328" ]) { (events, error, isNull) in
            guard let events = (events as? EventsResponse)?.events else{
                XCTFail()
                return
            }
            print("events.count = \(events.count)")
            XCTAssertEqual(events.count, 2, "API failed") //true: 2
        }
    }
}
