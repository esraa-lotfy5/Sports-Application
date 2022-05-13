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
        networkDelegate.fetchLists(urlID: 0, paramerters: [:]){(result, error) -> Void in
            guard let sports = (result as? SportsResponse)?.sports else{
                XCTFail()
                expectationOject.fulfill()
                return
            }
            XCTAssertEqual(sports.count, 34, "error in API items' count") // true : 34
            expectationOject.fulfill()
       }
       waitForExpectations(timeout: 5, handler: nil)
   }
    
    //all countires
    func testFetchCountriesList(){
          let expectationOject = expectation(description: "Waiting for the response")
        networkDelegate.fetchLists(urlID: 1, paramerters: [:]){(result, error) -> Void in
              guard let countries = (result as? CountriesResponse)?.countries else{
                  XCTFail()
                  expectationOject.fulfill()
                  return
              }
              XCTAssertEqual(countries.count, 257, "error in API items' count") // true : 257
              expectationOject.fulfill()
         }
         waitForExpectations(timeout: 5, handler: nil)
     }
    
    //all leagues
    func testFetchLeaguesList(){
          let expectationOject = expectation(description: "Waiting for the response")
        networkDelegate.fetchLists(urlID: 2, paramerters: ["c":"England","s":"Soccer"]){(result, error) -> Void in
            guard let leagues = (result as? LeaguesResponse)?.countries else{
                  XCTFail()
                  expectationOject.fulfill()
                  return
              }
              XCTAssertEqual(leagues.count, 10, "error in API items' count") // true : 10
              expectationOject.fulfill()
         }
         waitForExpectations(timeout: 15, handler: nil)
     }
}
