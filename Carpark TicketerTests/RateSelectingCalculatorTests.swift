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
            if let price = calculator.price(from:morning, to:evening)
            {
                XCTAssert(price == 13.00, "Price = " + String(price))
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
            
            
            if let price = calculator.price(from:evening, to:morning)
            {
                XCTAssert(price == 6.50, "Price = " + String(price))
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
            
            
            if let price = calculator.price(from:evening, to:morning)
            {
                XCTAssert(price == 10.00, "Price = " + String(price))
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
            if let price = calculator.price(from:morning, to:evening)
            {
                XCTAssert(price == 5.00, "Price = " + String(price))
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
            if let price = calculator.price(from:morning, to:evening)
            {
                XCTAssert(price == 10.00, "Price = " + String(price))
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
            if let price = calculator.price(from:morning, to:evening)
            {
                XCTAssert(price == 15.00, "Price = " + String(price))
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
            
            
            
            if let price = calculator.price(from:evening, to:morning)
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
            
            
            
            if let price = calculator.price(from:evening, to:morning)
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
