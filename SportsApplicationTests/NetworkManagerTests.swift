//
//  NetworkManagerTests.swift
//  SportsApplicationTests
//
//  Created by Esraa Lotfy  on 5/13/22.
//  Copyright © 2022 iti. All rights reserved.
//

import XCTest
@testable import SportsApplication

class NetworkManagerTests: XCTestCase {

    let networkDelegate = NetworkManager.delegate
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    //all sports
    func testFetchSportsList(){
        let expectationOject = expectation(description: "Waiting for the response")
        networkDelegate.fetchLists(urlID: 0, paramerters: [:]){(result, error,isNull) -> Void in
            guard let sports = (result as? SportsResponse)?.sports else{
                XCTFail()
                expectationOject.fulfill()
                return
            }
            XCTAssertEqual(sports.count, 34, "error in API items' count") // true : 34
            expectationOject.fulfill()
       }
       waitForExpectations(timeout: 15, handler: nil)
   }
    
    
    //all leagues
    func testFetchLeaguesList(){
          let expectationOject = expectation(description: "Waiting for the response")
        networkDelegate.fetchLists(urlID: 2, paramerters: ["s":"Soccer"]){(result, error,isNull) -> Void in
            guard let leagues = (result as? LeaguesResponse)?.countries else{
                  XCTFail()
                  expectationOject.fulfill()
                  return
              }
            print("leagues count : \(leagues.count)")
              XCTAssertEqual(leagues.count, 10, "error in API items' count") // true : 10
            
              expectationOject.fulfill()
         }
         waitForExpectations(timeout: 15, handler: nil)
     }
    
    //all teams
    func testFetchTeamsList(){
          let expectationOject = expectation(description: "Waiting for the response")
        networkDelegate.fetchLists(urlID: 3, paramerters: ["s":"Soccer", "c":"England"]){(result, error,isNull) -> Void in
            guard let teams = (result as? TeamsResponse)?.teams else{
                  XCTFail()
                  expectationOject.fulfill()
                  return
              }
            print("number of teams = \(teams.count)")
              XCTAssertEqual(teams.count, 50, "error in API items' count") // true : 50
              expectationOject.fulfill()
         }
         waitForExpectations(timeout: 15, handler: nil)
     }
    
    
    //all events
    func testFetchEventsList(){
          let expectationOject = expectation(description: "Waiting for the response")
        networkDelegate.fetchLists(urlID: 4, paramerters: ["id":"4328"]){(result, error,isNull) -> Void in
            guard let events = (result as? EventsResponse)?.events else{
                  XCTFail()
                  expectationOject.fulfill()
                  return
              }
            print("number of events = \(events.count)")
              XCTAssertEqual(events.count, 100, "error in API items' count") // true : 100
              expectationOject.fulfill()
         }
         waitForExpectations(timeout: 20, handler: nil)
     }
}
