//
//  DateExtentionTests.swift
//  Carpark Ticketer
//
//  Created by Geoff Burns on 20/6/17.
//  Copyright © 2017 Geoff Burns. All rights reserved.
//

import XCTest
@testable import Carpark_Ticketer

class DateExtentionTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testHours() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        
        let morning = "6:00 AM".toTime
        XCTAssert(morning != nil, "String to Date Success")
        if let morning = morning
        {
        XCTAssert(morning.hour == 6, "Hour = " + String(morning.hour))
        }
        
        let evening = "6:00 PM".toTime
    
        XCTAssert(evening != nil, "String to Date Success")
        
        if let evening = evening
        {
            XCTAssert(evening.hour == 18, "Hour = " + String(evening.hour))
            if let morning = morning
            {
                XCTAssert(evening.isTime(after: morning), "evening is after morning")
            }
        }

    }
    func testDays() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        
        let morning = "Sun 6:00 AM".toDayAndTime
        XCTAssert(morning != nil, "String to Date Success")
        if let morning = morning
        {
            XCTAssert(morning.hour == 6, "Hour = " + String(morning.hour))
            XCTAssert(morning.isWeekend, "Should be weekend")
            
        }
        
        let evening = "Mon 6:00 PM".toDayAndTime
        
        XCTAssert(evening != nil, "String to Date Success")
        
        if let evening = evening
        {
            XCTAssert(evening.hour == 18, "Hour = " + String(evening.hour))
             XCTAssert(!evening.isWeekend, "Should not be weekend")
            if let morning = morning
            {
                XCTAssert(evening.isNotSameDay(as: morning), "Should not be same day")
                XCTAssert(evening.isFollowingDay(to:  morning), "Should  be following day")
                
            }
        }
        
    }

    
    
}
