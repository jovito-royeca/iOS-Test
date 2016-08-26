//
//  Ride+CoreDataProperties.swift
//  Ride Guide
//
//  Created by Jovit Royeca on 26/08/2016.
//  Copyright © 2016 Jovit Royeca. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Ride {

    @NSManaged var rideID: NSNumber?
    @NSManaged var providerLogo: String?
    @NSManaged var priceInEuros: NSNumber?
    @NSManaged var departureTime: String?
    @NSManaged var arrivalTime: String?
    @NSManaged var numberOfStops: NSNumber?
    @NSManaged var rideType: RideType?

}
