//
//  HourlyRateCalculatorTests.swift
//  Carpark Ticketer
//
//  Created by Geoff Burns on 20/6/17.
//  Copyright © 2017 Geoff Burns. All rights reserved.
//

import XCTest
@testable import Carpark_Ticketer




class HourlyRateCalculatorTests: XCTestCase {
 
    let hourlyRate = HourlyRateCalculator.sharedInstance
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testLessThanOneHour() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let morning = "11:30 AM".toTime
        XCTAssert(morning != nil, "String to Date Success")
        
        let evening = "12:10 PM".toTime
        
        XCTAssert(evening != nil, "String to Date Success")
        
        if let evening = evening,  let morning = morning
        {
            if let price = hourlyRate.price(from:morning, to:evening)
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
    
    let morning = "11:30 AM".toTime
    XCTAssert(morning != nil, "String to Date Success")
    
    let evening = "12:31 PM".toTime
    
    XCTAssert(evening != nil, "String to Date Success")
    
    if let evening = evening,  let morning = morning
    {
        if let price = hourlyRate.price(from:morning, to:evening)
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
        
        let morning = "11:30 AM".toTime
        XCTAssert(morning != nil, "String to Date Success")
        
        let evening = "1:31 PM".toTime
        
        XCTAssert(evening != nil, "String to Date Success")
        
        if let evening = evening,  let morning = morning
        {
            if let price = hourlyRate.price(from:morning, to:evening)
            {
                XCTAssert(price == 15.00, "Price = " + String(price))
            }
            else
            {
                XCTFail()
            }
        }
        
        
        
    }


}
