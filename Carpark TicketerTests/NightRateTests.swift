//
//  NightRateTests.swift
//  Carpark Ticketer
//
//  Created by Geoff Burns on 20/6/17.
//  Copyright © 2017 Geoff Burns. All rights reserved.
//

import XCTest
@testable import Carpark_Ticketer

class NightRateTests: XCTestCase {
    let nightRate = NightRateCalculator.sharedInstance
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    func testOnTime() {
        
        let evening = "Tue 6:00 PM".toDayAndTime
        
        XCTAssert(evening != nil, "String to Date Success")
        
    
        if let evening = evening
        {
            var morning = evening.followingDay
            morning.setTime(to: "6:00 AM")
       
      
            if let price = nightRate.price(from:evening, to:morning)
            {
                XCTAssert(price == 6.50, "Price = " + String(price))
            }
            else
            {
                XCTFail()
            }
    
        }
    }
    
    func testOnTimeFri() {
  
        
        let evening = "Fri 6:00 PM".toDayAndTime
        
        XCTAssert(evening != nil, "String to Date Success")
        
        
        if let evening = evening
        {
            var morning = evening.followingDay
            morning.setTime(to: "6:00 AM")
            
            
            if let price = nightRate.price(from:evening, to:morning)
            {
                XCTAssert(price == 6.50, "Price = " + String(price))
            }
            else
            {
                XCTFail()
            }
            
            
            
        }
    }
    func testOnTimeSat() {
        
        
        let evening = "Sat 6:00 PM".toDayAndTime
        
        XCTAssert(evening != nil, "String to Date Success")
        
        
        if let evening = evening
        {
            var morning = evening.followingDay
            morning.setTime(to: "6:00 AM")
            XCTAssert(nightRate.price(from:evening, to:morning)==nil,"Should not give price")
          
        }
    }
    
    func testArriveTooEarly() {
        
        let evening = "Wed 5:59 PM".toDayAndTime
        
        XCTAssert(evening != nil, "String to Date Success")
        
        
        if let evening = evening
        {
            var morning = evening.followingDay
            morning.setTime(to: "6:00 AM")
            XCTAssert(nightRate.price(from:evening, to:morning)==nil,"Should not give price")
            
        }
    }

    func testLeaveTooLate() {
        
        let evening = "Wed 6:00 PM".toDayAndTime
        
        XCTAssert(evening != nil, "String to Date Success")
        
        
        if let evening = evening
        {
            var morning = evening.followingDay
            morning.setTime(to: "6:01 AM")
            XCTAssert(nightRate.price(from:evening, to:morning)==nil,"Should not give price")
            
        }
        
    }
    
    func testNotFollowingDay() {
        let evening = "Mon 6:00 PM".toDayAndTime
        
        XCTAssert(evening != nil, "String to Date Success")
        
        
        if let evening = evening
        {
            var morning = evening.followingDay.followingDay
            morning.setTime(to: "6:00 AM")
            XCTAssert(nightRate.price(from:evening, to:morning)==nil,"Should not give price")
            
        }
        
        
    }
    
}
