//
//  ObjectManager.swift
//  Cineko
//
//  Created by Jovit Royeca on 18/04/2016.
//  Copyright © 2016 Jovito Royeca. All rights reserved.
//

import UIKit
import CoreData

class ObjectManager: NSObject {

    // MARK: Constants
    static let BatchUpdateNotification = "BatchUpdateNotification"
    
    // MARK: Variables
    private var privateContext: NSManagedObjectContext {
        return CoreDataManager.sharedInstance.privateContext
    }
    private var mainObjectContext: NSManagedObjectContext {
        return CoreDataManager.sharedInstance.mainObjectContext
    }
    
    // MARK: Objects
    func findOrCreateRide(dict: [String: AnyObject]) -> Ride {
        let initializer = { (dict: [String: AnyObject], context: NSManagedObjectContext) -> Ride in
            return Ride(dictionary: dict, context: context)
        }
        
        return findOrCreateObject(dict, entityName: "Ride", objectKey: "rideID", objectValue: dict[Ride.Keys.RideID] as! NSObject, initializer: initializer) as! Ride
    }
    
    func findOrCreateRideType(dict: [String: AnyObject]) -> RideType {
        let initializer = { (dict: [String: AnyObject], context: NSManagedObjectContext) -> RideType in
            return RideType(dictionary: dict, context: context)
        }
        
        return findOrCreateObject(dict, entityName: "RideType", objectKey: "name", objectValue: dict[RideType.Keys.Name] as! NSObject, initializer: initializer) as! RideType
    }
    
    // MARK: Utility methods
    func findOrCreateObject(dict: [String: AnyObject], entityName: String, objectKey: String, objectValue: NSObject, initializer: (dict: [String: AnyObject], context: NSManagedObjectContext) -> AnyObject) -> AnyObject {
        var object:AnyObject?
        
        let fetchRequest = NSFetchRequest(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "%K == %@", objectKey, objectValue)
        
        do {
            if let m = try privateContext.executeFetchRequest(fetchRequest).first {
                object = m
                
            } else {
                object = initializer(dict: dict, context: privateContext)
                CoreDataManager.sharedInstance.savePrivateContext()
            }
            
        } catch let error as NSError {
            print("Error in fetch \(error), \(error.userInfo)")
        }
        
        return object!
    }

    func findObjects(entityName: String, predicate: NSPredicate?, sorters: [NSSortDescriptor]?) -> [AnyObject] {
        let fetchRequest = NSFetchRequest(entityName: entityName)
        fetchRequest.predicate = predicate
        fetchRequest.sortDescriptors = sorters
        
        var objects:[AnyObject]?
        
        do {
            objects = try privateContext.executeFetchRequest(fetchRequest)
            
        } catch let error as NSError {
            print("Error in fetch \(error), \(error.userInfo)")
        }
        
        return objects!
    }
    
    func fetchObjects(fetchRequest: NSFetchRequest) -> [AnyObject] {
        var objects:[AnyObject]?
        
        do {
            objects = try privateContext.executeFetchRequest(fetchRequest)
            
        } catch let error as NSError {
            print("Error in fetch \(error), \(error.userInfo)")
        }
        
        return objects!
    }
    
    func deleteObject(entityName: String, objectKey: String, objectValue: NSObject) {
        let fetchRequest = NSFetchRequest(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "%K == %@", objectKey, objectValue)
        
        do {
            if let m = try privateContext.executeFetchRequest(fetchRequest).first as? NSManagedObject {
                privateContext.deleteObject(m)
                CoreDataManager.sharedInstance.savePrivateContext()
                
            }
            
        } catch let error as NSError {
            print("Error in fetch \(error), \(error.userInfo)")
        }
    }
    
    func batchUpdate(entityName: String, propertiesToUpdate: [String: AnyObject], predicate: NSPredicate) {
        // code adapted from: http://code.tutsplus.com/tutorials/core-data-and-swift-batch-updates--cms-25120
        // Initialize Batch Update Request
        let batchUpdateRequest = NSBatchUpdateRequest(entityName: entityName)
        
        // Configure Batch Update Request
        batchUpdateRequest.resultType = .UpdatedObjectIDsResultType
        batchUpdateRequest.propertiesToUpdate = propertiesToUpdate
        batchUpdateRequest.predicate = predicate
        
        do {
            // Execute Batch Request
            let batchUpdateResult = try privateContext.executeRequest(batchUpdateRequest) as! NSBatchUpdateResult
            
            // Extract Object IDs
            let objectIDs = batchUpdateResult.result as! [NSManagedObjectID]
            
            for objectID in objectIDs {
                let managedObject = privateContext.objectWithID(objectID)
                privateContext.refreshObject(managedObject, mergeChanges: false)
            }
            NSNotificationCenter.defaultCenter().postNotificationName(ObjectManager.BatchUpdateNotification, object: nil, userInfo: nil)
            
        } catch {}
    }
    
    // MARK: - Shared Instance
    static let sharedInstance = ObjectManager()
}
