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
    dispatch_async(dispatch_get_main_queue(), ^{
        [self displayRide:ride];
    });
}

- (void) displayRide:(Ride*) ride {
    [self.logoView sd_setImageWithURL:ride.logoURL];
    
    if (ride.departureTime) {
        self.scheduleLabel.text = [NSString stringWithFormat:@"%@ -", ride.departureTime];
    } else {
        self.scheduleLabel.text = nil;
    }
    
    if (ride.arrivalTime) {
        self.scheduleLabel.text = [NSString stringWithFormat:@"%@ %@", self.scheduleLabel.text, ride.arrivalTime];
    }
    
    if (ride.numberOfStops) {
        int stops = [ride.numberOfStops intValue];
        self.stopsLabel.text = stops > 0 ? [NSString stringWithFormat:@"%d stop%@", stops, (stops > 1 ? @"s": @"")] : @"Direct";
        
    } else {
        self.stopsLabel.text = nil;
    }
    
    if (ride.priceInEuros) {
        self.priceLabel.text = [NSString stringWithFormat:@"%@%.2f", kUnicodeEuro, [ride.priceInEuros doubleValue]];
    } else {
        self.priceLabel.text = nil;
    }
    
    NSTimeInterval duration = [ride.duration doubleValue];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.timeStyle = NSDateFormatterShortStyle;
    dateFormatter.dateFormat = @"k:mm"; // k = Hour in 1~24, mm = Minute
    dateFormatter.timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    NSDate * date = [NSDate dateWithTimeIntervalSinceReferenceDate:duration];
    
    self.durationLabel.text = [NSString stringWithFormat:@"%@h", [dateFormatter stringFromDate:date]];
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
