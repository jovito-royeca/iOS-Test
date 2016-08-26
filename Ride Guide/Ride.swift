//
//  Ride.swift
//  Ride Guide
//
//  Created by Jovit Royeca on 26/08/2016.
//  Copyright © 2016 Jovit Royeca. All rights reserved.
//

import Foundation
import CoreData


class Ride: NSManagedObject {

    struct Keys {
        static let RideID = "id"
        static let ProviderLogo = "provider_logo"
        static let PriceInEuros = "price_in_euros"
        static let DepartureTime = "departure_time"
        static let ArrivalTime = "arrival_time"
        static let NumberOfStops = "number_of_stops"
    }
    
    override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext?) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }
    
    init(dictionary: [String : AnyObject], context: NSManagedObjectContext) {
        let entity =  NSEntityDescription.entityForName("Ride", inManagedObjectContext: context)!
        super.init(entity: entity,insertIntoManagedObjectContext: context)
        
        update(dictionary)
    }
    
    func update(dictionary: [String : AnyObject]) {
        rideID = dictionary[Keys.RideID] as? NSNumber
        providerLogo = dictionary[Keys.ProviderLogo] as? String
        priceInEuros = dictionary[Keys.PriceInEuros] as? NSNumber
        departureTime = dictionary[Keys.DepartureTime] as? String
        arrivalTime = dictionary[Keys.ArrivalTime] as? String
        numberOfStops = dictionary[Keys.NumberOfStops] as? NSNumber
        
    }
    
    func logoURL() -> NSURL? {
        if let providerLogo = providerLogo {
            return NSURL(string: providerLogo.stringByReplacingOccurrencesOfString("{size}", withString: "63"))
        } else {
            return nil
        }
    }
    
    func duration() -> NSTimeInterval {
        if let a = departureTime,
            let b = arrivalTime {
        
        
            let dateFormatter = NSDateFormatter()
            dateFormatter.timeStyle = .ShortStyle
            dateFormatter.dateFormat = "k:mm" // k = Hour in 1~24, mm = Minute
            let timeZone = NSTimeZone(name: "UTC")
            dateFormatter.timeZone = timeZone
            if let dateA = dateFormatter.dateFromString(a),
                let dateB = dateFormatter.dateFromString(b) {
            
                return dateB.timeIntervalSinceDate(dateA)
            }
        }
        
        return 0
    }

}
