//
//  MainViewController.h
//  Ride Guide
//
//  Created by Jovit Royeca on 26/08/2016.
//  Copyright © 2016 Jovit Royeca. All rights reserved.
//

@import UIKit;
@import CoreData;

#import "Ride_Guide-Swift.h"
#import "RideTableViewCell.h"

@interface MainViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate>

// MARK: Outlets
@property (weak, nonatomic) IBOutlet UIView *segmentedView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

// MARK: Actions
- (IBAction)sortAction:(UIBarButtonItem *)sender;
- (IBAction)segmentedAction:(UISegmentedControl *)sender;

// MARK: Custom methods
- (void) loadRides;

@end

