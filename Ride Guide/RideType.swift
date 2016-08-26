//
//  RideType.swift
//  Ride Guide
//
//  Created by Jovit Royeca on 26/08/2016.
//  Copyright © 2016 Jovit Royeca. All rights reserved.
//

import Foundation
import CoreData


class RideType: NSManagedObject {

    struct Keys {
        static let Name = "name"
    }
    
    override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext?) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }
    
    init(dictionary: [String : AnyObject], context: NSManagedObjectContext) {
        let entity =  NSEntityDescription.entityForName("RideType", inManagedObjectContext: context)!
        super.init(entity: entity,insertIntoManagedObjectContext: context)
        
        update(dictionary)
    }
    
    func update(dictionary: [String : AnyObject]) {
        name = dictionary[Keys.Name] as? String
    }

}
