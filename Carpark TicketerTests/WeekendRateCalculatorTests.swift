//
//  WeekendRateCalculatorTests.swift
//  Carpark Ticketer
//
//  Created by Geoff Burns on 20/6/17.
//  Copyright © 2017 Geoff Burns. All rights reserved.
//

import XCTest
@testable import Carpark_Ticketer



class WeekendRateCalculatorTests: XCTestCase {
     let weekendRate = WeekendRateCalculator.sharedInstance
    
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    func testOnTime() {
        
        let evening = "Sat 12:01 AM".toDayAndTime
        
        XCTAssert(evening != nil, "String to Date Success")
        
        
        if let evening = evening
        {
            var morning = evening.followingDay
            morning.setTime(to: "9:00 AM")
            
            
            if let price = weekendRate.price(from:evening, to:morning)
            {
                XCTAssert(price == 10.00, "Price = " + String(price))
            }
            else
            {
                XCTFail()
            }
            
        }
    }
    
    func testOnTimeFri() {
        
        
        let evening = "Fri 11:59 PM".toDayAndTime
        
        XCTAssert(evening != nil, "String to Date Success")
        
        
        if let evening = evening
        {
            var morning = evening.followingDay
            morning.setTime(to: "11:00 AM")
            
            XCTAssert(weekendRate.price(from:evening, to:morning)==nil,"Should not give price")
       
            
            
        }
    }
    
}
