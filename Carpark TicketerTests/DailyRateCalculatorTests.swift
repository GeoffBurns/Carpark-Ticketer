//
//  DailyRateCalculatorTests.swift
//  Carpark Ticketer
//
//  Created by Geoff Burns on 20/6/17.
//  Copyright © 2017 Geoff Burns. All rights reserved.
//

import XCTest
@testable import Carpark_Ticketer

class DailyRateCalculatorTests: XCTestCase {
    let dailyRate = DailyRateCalculator.sharedInstance
    
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testTwoDays() {
        
        let evening = "Mon 6:00 AM".toDayAndTime
        
        XCTAssert(evening != nil, "String to Date Success")
        
        
        if let evening = evening
        {
            let morning = evening.followingDay
     
            
            
            if let price = dailyRate.price(from:evening, to:morning)
            {
                XCTAssert(price == 40.00, "Price = " + String(price))
            }
            else
            {
                XCTFail()
            }
            
        }
    }
    
    func testThreeDays() {
        
        let evening = "Mon 6:00 AM".toDayAndTime
        
        XCTAssert(evening != nil, "String to Date Success")
        
        
        if let evening = evening
        {
            let morning = evening.followingDay.followingDay
            
            
            
            if let price = dailyRate.price(from:evening, to:morning)
            {
                XCTAssert(price == 60.00, "Price = " + String(price))
            }
            else
            {
                XCTFail()
            }
            
        }
    }
    
}
