//
//  RideTableViewCell.m
//  Ride Guide
//
//  Created by Jovit Royeca on 26/08/2016.
//  Copyright © 2016 Jovit Royeca. All rights reserved.
//

#import "RideTableViewCell.h"
@import SDWebImage;

@interface RideTableViewCell ()

- (void) displayRide:(Ride*) ride;

@end

@implementation RideTableViewCell

// MARK: Custom methods
- (void) setRideOID:(NSManagedObjectID *)rideOID {
    _rideOID = rideOID;
    
    Ride *ride = [[[CoreDataManager sharedInstance] mainObjectContext] objectWithID:rideOID];
    [self displayRide:ride];
}

- (void) displayRide:(Ride*) ride {
    [self.logoView sd_setImageWithURL:ride.logoURL];
    
    if (ride.departureTime && ride.arrivalTime) {
        self.scheduleLabel.text = [NSString stringWithFormat:@"%@ - %@", ride.departureTime, ride.arrivalTime];
    } else {
        self.scheduleLabel.text = @"x";
    }
    
    if (ride.priceInEuros) {
        self.priceLabel.text = [NSString stringWithFormat:@"%@%.2f", kUnicodeEuro, [ride.priceInEuros doubleValue]];
    } else {
        self.priceLabel.text = @"x";
    }
}

// MARK: Overrides
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
