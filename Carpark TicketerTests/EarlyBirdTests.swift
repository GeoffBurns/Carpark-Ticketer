//
//  EarlyBirdTests.swift
//  Carpark Ticketer
//
//  Created by Geoff Burns on 20/6/17.
//  Copyright © 2017 Geoff Burns. All rights reserved.
//

import XCTest

@testable import Carpark_Ticketer

class EarlyBirdTests: XCTestCase {
    
    
    let earlyBird = EarlyBirdCalculator.sharedInstance
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testOnTime() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let morning = "6:00 AM".toTime
        XCTAssert(morning != nil, "String to Date Success")
  
        let evening = "6:00 PM".toTime
        
        XCTAssert(evening != nil, "String to Date Success")
        
        if let evening = evening,  let morning = morning
            {
                if let price = earlyBird.price(from:morning, to:evening)
                {
                XCTAssert(price == 13.00, "Price = " + String(price))
                }
                else
                {
                    XCTFail()
                }
            }
      

        
    }
    func testJustOnTime() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let morning = "9:00 AM".toTime
        XCTAssert(morning != nil, "String to Date Success")
        
        let evening = "11:30 PM".toTime
        
        XCTAssert(evening != nil, "String to Date Success")
        
        if let evening = evening,  let morning = morning
        {
            if let price = earlyBird.price(from:morning, to:evening)
            {
                XCTAssert(price == 13.00, "Price = " + String(price))
            }
            else
            {
                XCTFail()
            }
        }
        
        
        
    }

    func testArriveTooEarly() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let morning = "5:59 AM".toTime
        XCTAssert(morning != nil, "String to Date Success")
        
        let evening = "6:00 PM".toTime
        
        XCTAssert(evening != nil, "String to Date Success")
        
        if let evening = evening,  let morning = morning
        {
            XCTAssert(earlyBird.price(from:morning, to:evening) == nil, "Should Give No Price")
      
        }
        
        
    }
    func testArriveTooLate() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let morning = "9:01 AM".toTime
        XCTAssert(morning != nil, "String to Date Success")
        
        let evening = "6:00 PM".toTime
        
        XCTAssert(evening != nil, "String to Date Success")
        
        if let evening = evening,  let morning = morning
        {
            XCTAssert(earlyBird.price(from:morning, to:evening) == nil, "Should Give No Price")
            
        }
        
        
    }
    func testLeaveTooEarly() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let morning = "9:00 AM".toTime
        XCTAssert(morning != nil, "String to Date Success")
        
        let evening = "3:29 PM".toTime
        
        XCTAssert(evening != nil, "String to Date Success")
        
        if let evening = evening,  let morning = morning
        {
            XCTAssert(earlyBird.price(from:morning, to:evening) == nil, "Should Give No Price")
            
        }
        
        
    }
    func testLeaveTooLate() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let morning = "9:00 AM".toTime
        XCTAssert(morning != nil, "String to Date Success")
        
        let evening = "11:31 PM".toTime
        
        XCTAssert(evening != nil, "String to Date Success")
        
        if let evening = evening,  let morning = morning
        {
            XCTAssert(earlyBird.price(from:morning, to:evening) == nil, "Should Give No Price")
            
        }
        
        
    }
    
    func testNotSameDay() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let morning = "Sun 9:00 AM".toDayAndTime
        XCTAssert(morning != nil, "String to Date Success")
        
        let evening = "Mon 11:29 PM".toDayAndTime
        
        XCTAssert(evening != nil, "String to Date Success")
        
        if let evening = evening,  let morning = morning
        {
            XCTAssert(earlyBird.price(from:morning, to:evening) == nil, "Should Give No Price")
            
        }
        
        
    }
}
