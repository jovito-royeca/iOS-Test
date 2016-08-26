//
//  RideManager.swift
//  Ride Guide
//
//  Created by Jovit Royeca on 26/08/2016.
//  Copyright © 2016 Jovit Royeca. All rights reserved.
//

import Foundation

struct RideManagerConstants {
    static let TrainPath     = "https://api.myjson.com/bins/3zmcy"
    static let BusPath       = "https://api.myjson.com/bins/37yzm"
    static let FlightPath    = "https://api.myjson.com/bins/w60i"
}

class RideManager: NSObject {
    
    func x() {
        
    }
    
    func downloadRideData(rideType:String, completion: (arrayIDs: [AnyObject]) -> Void) {
        var urlString:String?
        
        let httpMethod:HTTPMethod = .Get
        var rideIDs = [NSNumber]()
        
        if rideType == "Train" {
            urlString = "\(RideManagerConstants.TrainPath)"
        } else if rideType == "Bus" {
            urlString = "\(RideManagerConstants.BusPath)"
        } else if rideType == "Flight" {
            urlString = "\(RideManagerConstants.FlightPath)"
        }
        
        let success = { (results: AnyObject!) in
            if let dict = results as? [[String: AnyObject]] {
                
                for ride in dict {
                    let r = ObjectManager.sharedInstance.findOrCreateRide(ride)
                    let rt = ObjectManager.sharedInstance.findOrCreateRideType(["name": rideType])
                    
                    r.rideType = rt
                    
                    if let rideID = r.rideID {
                        rideIDs.append(rideID)
                    }
                }
            }
            
            CoreDataManager.sharedInstance.savePrivateContext()
            completion(arrayIDs: rideIDs)
        }
        
        let failure = { (error: NSError?) -> Void in
            completion(arrayIDs: rideIDs)
        }
        
        NetworkManager.sharedInstance.exec(httpMethod, urlString: urlString, headers: nil, parameters: nil, values: nil, body: nil, dataOffset: 0, isJSON: true, success: success, failure: failure)
    }
    
    // MARK: Shared Instance
    static let sharedInstance = RideManager()
}
