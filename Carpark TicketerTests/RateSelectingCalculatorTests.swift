//
//  RateSelectingCalculatorTests.swift
//  Carpark Ticketer
//
//  Created by Geoff Burns on 20/6/17.
//  Copyright © 2017 Geoff Burns. All rights reserved.
//

import XCTest

@testable import Carpark_Ticketer

class RateSelectingCalculatorTests: XCTestCase {
    
    
     let calculator = RateSelectingCalculator.sharedInstance
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testEarlyBird() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let morning = "6:00 AM".toTime
        XCTAssert(morning != nil, "String to Date Success")
        
        let evening = "6:00 PM".toTime
        
        XCTAssert(evening != nil, "String to Date Success")
        
        if let evening = evening,  let morning = morning
        {
            if let priceAndRate = calculator.priceAndRate(from:morning, to:evening)
            {
                XCTAssert(priceAndRate.0 == 13.00, "Price = " + String(priceAndRate.0))
                
                XCTAssert(priceAndRate.1 == "Early Bird", "Rate = " + priceAndRate.1)
                
            }
            else
            {
                XCTFail()
            }
        }
        
        
        
    }
    func testNightRate() {
        
        let evening = "Tue 6:00 PM".toDayAndTime
        
        XCTAssert(evening != nil, "String to Date Success")
        
        
        if let evening = evening
        {
            var morning = evening.followingDay
            morning.setTime(to: "6:00 AM")
            
            if let priceAndRate = calculator.priceAndRate(from:evening, to:morning)
            {
                XCTAssert(priceAndRate.0 == 6.50, "Price = " + String(priceAndRate.0))
                XCTAssert(priceAndRate.1 == "Night", "Rate = " + priceAndRate.1)
            }
            else
            {
                XCTFail()
            }
            
        }
    }
    
    func testWeekendRate() {
        
        let evening = "Sat 12:01 AM".toDayAndTime
        
        XCTAssert(evening != nil, "String to Date Success")
        
        
        if let evening = evening
        {
            var morning = evening.followingDay
            morning.setTime(to: "9:00 AM")
            
        
            if let priceAndRate = calculator.priceAndRate(from:evening, to:morning)
            {
                XCTAssert(priceAndRate.0 == 10.00, "Price = " + String(priceAndRate.0))
                XCTAssert(priceAndRate.1 == "Weekend", "Rate = " + priceAndRate.1)
            }
                
            else
            {
                XCTFail()
            }
            
        }
    }
    
    func testLessThanOneHour() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let morning = "Tue 11:30 AM".toDayAndTime
        XCTAssert(morning != nil, "String to Date Success")
        
        let evening = "Tue 12:10 PM".toDayAndTime
        
        XCTAssert(evening != nil, "String to Date Success")
        
        if let evening = evening,  let morning = morning
        {
      
            if let priceAndRate = calculator.priceAndRate(from:morning, to:evening)
            {
                XCTAssert(priceAndRate.0 == 5.00, "Price = " + String(priceAndRate.0))
                
                XCTAssert(priceAndRate.1 == "Standard", "Rate = " + priceAndRate.1)
            }
            else
            {
                XCTFail()
            }
        }
    }
    
    func testMoreThanOneHour() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let morning = "Tue 11:30 AM".toDayAndTime
        XCTAssert(morning != nil, "String to Date Success")
        
        let evening = "Tue 12:31 PM".toDayAndTime
        
        XCTAssert(evening != nil, "String to Date Success")
        
        if let evening = evening,  let morning = morning
        {
            if let priceAndRate = calculator.priceAndRate(from:morning, to:evening)
            {
                XCTAssert(priceAndRate.0 == 10.00, "Price = " + String(priceAndRate.0))
                
                XCTAssert(priceAndRate.1 == "Standard", "Rate = " + priceAndRate.1)
            }
            else
            {
                XCTFail()
            }
        }
    }
    
    func testThreeHours() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let morning = "Tue 11:30 AM".toDayAndTime
        XCTAssert(morning != nil, "String to Date Success")
        
        let evening = "Tue 1:31 PM".toDayAndTime
        
        XCTAssert(evening != nil, "String to Date Success")
        
        if let evening = evening,  let morning = morning
        {
            if let priceAndRate = calculator.priceAndRate(from:morning, to:evening)
            {
                XCTAssert(priceAndRate.0 == 15.00, "Price = " + String(priceAndRate.0))
                
                XCTAssert(priceAndRate.1 == "Standard", "Rate = " + priceAndRate.1)
            }
            else
            {
                XCTFail()
            }
        }
    
    }
    func testTwoDays() {
        
        let evening = "Mon 6:00 AM".toDayAndTime
        
        XCTAssert(evening != nil, "String to Date Success")
        
        
        if let evening = evening
        {
            let morning = evening.followingDay
            
            
            
            if let priceAndRate = calculator.priceAndRate(from:evening, to:morning)
            {
                XCTAssert(priceAndRate.0 == 40.00, "Price = " + String(priceAndRate.0))
                
                XCTAssert(priceAndRate.1 == "Standard", "Rate = " + priceAndRate.1)
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
            
            
            if let priceAndRate = calculator.priceAndRate(from:evening, to:morning)
            {
                XCTAssert(priceAndRate.0 == 60.00, "Price = " + String(priceAndRate.0))
                
                XCTAssert(priceAndRate.1 == "Standard", "Rate = " + priceAndRate.1)
            }
            else
            {
                XCTFail()
            }
            
        }
    }
    
}
