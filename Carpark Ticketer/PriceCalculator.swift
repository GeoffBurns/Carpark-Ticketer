//
//  PriceCalculator.swift
//  Carpark Ticketer
//
//  Created by Geoff Burns on 20/6/17.
//  Copyright © 2017 Geoff Burns. All rights reserved.
//

import Foundation

// Strategy Pattern (Abstract Strategy)
// Gives a common interface for different Price Calculators
public protocol PriceCalculatorStrategy
{
    // normally using Floats for currency is a no-no but there isn't much currency arithmatic or comparsion in this project to cause problems 
    // if this project's scope is expanded it might be worthwhile creating a money class
    func price(from start: Date, to end: Date) -> Double?
    
     func priceAndRate(from start: Date, to end: Date) -> (Double,String)?
}

// Chain of Responsibility Pattern
// uses the first type of calculator in the list to give an answer
open class RateSelectingCalculator
{
    // Singleton Pattern
    open static let sharedInstance = RateSelectingCalculator()
    fileprivate init() { }
    
    let calculators : [PriceCalculatorStrategy]   = [
    EarlyBirdCalculator.sharedInstance,
    NightRateCalculator.sharedInstance,
    WeekendRateCalculator.sharedInstance,
    DailyRateCalculator.sharedInstance,
    HourlyRateCalculator.sharedInstance]
    
    public func price(from start: Date, to end: Date) -> Double? {
        
      for calculator in calculators
      {
        if let price = calculator.price(from:start, to:end)
        {
            return price
        }
        
        }
        return nil
    }
    public func priceAndRate(from start: Date, to end: Date) -> (Double,String)? {
        
        for calculator in calculators
        {
            if let priceAndRate = calculator.priceAndRate(from:start, to:end)
            {
                return priceAndRate
            }
            
        }
        return nil
    }
    public func priceText(from start: Date, to end: Date) -> String {
        
        if start > end
        {
            return "Start Date is After End Date"
        }
        if let price = self.price(from: start, to: end)
        {
            let rate = price as NSNumber
            let formatter = NumberFormatter()
            formatter.numberStyle = .currency
        
            return formatter.string(from: rate) ?? "Error"
        }
        
        return "Error"
    }
    public func priceAndRateText(from start: Date, to end: Date) -> (String,String) {
        
        if start > end
        {
            return ("Start Date is After End Date","")
        }
        if let priceAndRate = self.priceAndRate(from: start, to: end)
        {
            let price = priceAndRate.0 as NSNumber
            let rate = priceAndRate.1
            let formatter = NumberFormatter()
            formatter.numberStyle = .currency
            
            return (formatter.string(from: price) ?? "Error",rate)
        }
        
        return  ("Error","")
    }
}

// Strategy Pattern (Concrete Strategy)
// Price Calculator for the Early Bird Rate
open class EarlyBirdCalculator : PriceCalculatorStrategy
{
    
    // Singleton Pattern
    open static let sharedInstance = EarlyBirdCalculator()
    fileprivate init() { }
    
    public func price(from start: Date, to end: Date) -> Double? {
        
    if start.isNotSameDay(as: end)
      {
        return nil
      }
    if start.isTime(after: "6:00 AM") && start.isTime(before: "9:00 AM")
        && end.isTime(after: "3:30 PM") && end.isTime(before: "11:30 PM")
    {
        return 13.00
    }
    
    return nil
    }
    
    public func priceAndRate(from start: Date, to end: Date) ->  (Double,String)?
    {
        if let price = self.price(from: start, to: end) { return (price,"Early Bird") }
        
        return nil
    }
}
// Strategy Pattern (Concrete Strategy)
// Price Calculator for the Night Rate
open class NightRateCalculator : PriceCalculatorStrategy
    {
        // Singleton Pattern
        open static let sharedInstance = NightRateCalculator()
        fileprivate init() { }
        
        public func price(from start: Date, to end: Date) -> Double? {
            
            if end.isNotFollowingDay(to: start)
            {
                return nil
            }
            if start.isWeekend && end.isWeekend
            {
                return nil
            }
            if start.isTime(after: "6:00 PM")
                && end.isTime(before: "6:00 AM")
            {
                return 6.50
            }
            
            return nil
        }
    public func priceAndRate(from start: Date, to end: Date) ->  (Double,String)?
    {
        if let price = self.price(from: start, to: end) { return (price,"Night") }
        
        return nil
    }

}
// Strategy Pattern (Concrete Strategy)
// Price Calculator for the Weekend Rate
open class WeekendRateCalculator : PriceCalculatorStrategy
    {
        // Singleton Pattern
        open static let sharedInstance = WeekendRateCalculator()
        fileprivate init() { }
        
        public func price(from start: Date, to end: Date) -> Double? {
            
            if end.isNotSameDay(as: start) && end.isNotFollowingDay(to: start)
            {
                return nil
            }
            if start.isNotWeekend || end.isNotWeekend
            {
                return nil
            }
        
            return 10.00
          
        }
    public func priceAndRate(from start: Date, to end: Date) ->  (Double,String)?
    {
        if let price = self.price(from: start, to: end) { return (price,"Weekend") }
        
        return nil
    }
 
}

// Strategy Pattern (Concrete Strategy)
// Price Calculator for the Hourly Rate
open class HourlyRateCalculator : PriceCalculatorStrategy
        {
            // Singleton Pattern
            open static let sharedInstance = HourlyRateCalculator()
            fileprivate init() { }
            
            public func price(from start: Date, to end: Date) -> Double? {
                
                if end.isNotSameDay(as: start)
                {
                    return nil
                }
                
                let noOfMinutes = start.noOfMinutes(to:  end)
                
                if noOfMinutes < 60 { return 5.00 }
                else if noOfMinutes < 120 { return 10.00 }
                else if noOfMinutes < 180 { return 15.00 }
                
                return 20.00
                
            }
    public func priceAndRate(from start: Date, to end: Date) ->  (Double,String)?
    {
        if let price = self.price(from: start, to: end) { return (price,"Standard") }
        
        return nil
    }
    

}

// Strategy Pattern (Concrete Strategy)
// Price Calculator for the Daily Rate
open class DailyRateCalculator : PriceCalculatorStrategy
        {
           // Singleton Pattern
            open static let sharedInstance = DailyRateCalculator()
            fileprivate init() { }
            
            public func price(from start: Date, to end: Date) -> Double? {
                
                if end.isSameDay(as: start)
                {
                    return nil
                }
                
                let noOfDays = start.noOfDays(to: end) + 1
                
                return 20.00 * Double(noOfDays)

            }
    public func priceAndRate(from start: Date, to end: Date) ->  (Double,String)?
    {
        if let price = self.price(from: start, to: end) { return (price,"Standard") }
        
        return nil
    }
    
}






