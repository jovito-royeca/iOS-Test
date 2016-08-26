//
//  RideTableViewCell.h
//  Ride Guide
//
//  Created by Jovit Royeca on 26/08/2016.
//  Copyright © 2016 Jovit Royeca. All rights reserved.
//

@import UIKit;
@import CoreData;

#define kRideTableViewCellHeight     88
#define kUnicodeEuro                 @"\U000020AC"

#import "Ride_Guide-Swift.h"

@interface RideTableViewCell : UITableViewCell

// MARK: Variables
@property(strong,nonatomic) NSManagedObjectID* rideOID;

// MARK: Outlets
@property (weak, nonatomic) IBOutlet UIImageView *logoView;
@property (weak, nonatomic) IBOutlet UILabel *scheduleLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *stopsLabel;
@property (weak, nonatomic) IBOutlet UILabel *durationLabel;


@end
