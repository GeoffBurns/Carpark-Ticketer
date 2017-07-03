//
//  DateExtentions.swift
//  Carpark Ticketer
//
//  Created by Geoff Burns on 20/6/17.
//  Copyright © 2017 Geoff Burns. All rights reserved.
//

import Foundation

extension Date
{
    public var year : Int
    {
        return Calendar.current.component(.year, from: self)
    }
    
    public var month : Int
    {
        return Calendar.current.component(.month, from: self)
    }
    
    public var day : Int
    {
        return Calendar.current.component(.day, from: self)
    }
    public var hour : Int
    {
        return Calendar.current.component(.hour, from: self)
    }
    public var minute : Int
    {
        return Calendar.current.component(.minute, from: self)
    }
    public var second : Int
    {
        return Calendar.current.component(.second, from: self)
    }
    public var weekday : Int
    {
        return Calendar.current.component(.weekday, from: self)
    }
    public var isWeekend : Bool
    {
       return Calendar.current.isDateInWeekend(self)
    }
    public var isNotWeekend : Bool
    {
        return !self.isWeekend
    }
    public func isSameDay(as rhs:Date) -> Bool
    {
        return self.year == rhs.year && self.month == rhs.month && self.day == rhs.day
    }
    public var followingDay : Date
    {
        var increment = DateComponents()
        increment.day = 1
        return Calendar.current.date(byAdding: increment, to: self)!
        
    }
    public func isFollowingDay(to rhs:Date) -> Bool
    {
        let nextDay = rhs.followingDay
        
        return nextDay.year == self.year && nextDay.month == self.month && nextDay.day == self.day
    }
    
    public func isNotSameDay(as rhs:Date) -> Bool
    {
        return !isSameDay(as:rhs)
    }
    public func isNotFollowingDay(to rhs:Date) -> Bool
    {
        return !isFollowingDay(to:rhs)
    }
    
    public func isTime(after rhs:Date) -> Bool
    {
        return self.hour > rhs.hour || ( self.hour == rhs.hour && self.minute >= rhs.minute )
    }
    public func isTime(before rhs:Date) -> Bool
    {
        return self.hour < rhs.hour || ( self.hour == rhs.hour && self.minute <= rhs.minute )
    }
    
    public func isTime(after rhs:String) -> Bool
    {
        return self.isTime(after: rhs.toTime!)
    }
    public func isTime(before rhs:String) -> Bool
    {
        return self.isTime(before: rhs.toTime!)
    }
    public mutating func setTime(to rhs:String)
    {
        let calendar = Calendar.current
        var components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from:  self)
        if let newTime = rhs.toTime
        {
            components.hour = newTime.hour
            components.minute = newTime.minute
            components.second = 0
            
            self = calendar.date(from: components)!
        }
    }
    
    func interval(ofComponent comp: Calendar.Component, fromDate date: Date) -> Int {
        
        let currentCalendar = Calendar.current
        
        guard let start = currentCalendar.ordinality(of: comp, in: .era, for: date) else { return 0 }
        guard let end = currentCalendar.ordinality(of: comp, in: .era, for: self) else { return 0 }
        
        return end - start
    }
    
    public func noOfHours(to rhs:Date) -> Int
    {
        return rhs.interval(ofComponent: .hour,fromDate: self)
    }
    public func noOfHours(from rhs:Date) -> Int
    {
        return self.interval(ofComponent: .hour,fromDate: rhs)
    }
    public func noOfMinutes(to rhs:Date) -> Int
    {
        return rhs.interval(ofComponent: .minute,fromDate: self)
    }
    public func noOfMinutes(from rhs:Date) -> Int
    {
        return self.interval(ofComponent: .minute,fromDate: rhs)
    }
    public func noOfDays(to rhs:Date) -> Int
    {
        return rhs.interval(ofComponent: .day,fromDate: self)
    }
    public func noOfDays(from rhs:Date) -> Int
    {
        return self.interval(ofComponent: .day,fromDate: rhs)
    }
}

extension String
{
    public var toTime : Date?
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        
        return dateFormatter.date(from: self)
    }
    public var toDayAndTime : Date?
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E hh:mm a"
        
        return dateFormatter.date(from: self)
    }
}
