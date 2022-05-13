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
    func testfetchSportsList(){
        mockObject.fetchSportsList(urlID: 0) { (sports, error) in
            guard let sports = (sports as? SportsResponse)?.sports else{
                XCTFail()
                return
            }
            XCTAssertEqual(sports.count, 34, "API failed")
        }
    }
    
    //test for all countries list
    func testfetchCountriesList(){
        mockObject.fetchSportsList(urlID: 1) { (countries, error) in
            guard let countries = (countries as? CountriesResponse)?.countries else{
                XCTFail()
                return
            }
            XCTAssertEqual(sports.count, 257, "API failed")
        }
    }
}
