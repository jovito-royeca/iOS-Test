//
//  MainViewController.m
//  Ride Guide
//
//  Created by Jovit Royeca on 26/08/2016.
//  Copyright © 2016 Jovit Royeca. All rights reserved.
//

#import "MainViewController.h"
@import MBProgressHUD;

@interface MainViewController ()

@property (strong,nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong,nonatomic) NSFetchRequest *fetchRequest;

@end

@implementation MainViewController

// MARK: Overrides
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:@"segmentedTableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"RideTableViewCell" bundle:nil] forCellReuseIdentifier:@"rideTableViewCell"];
    
    [self loadRides];
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// MARK: Actions
- (IBAction)sortAction:(UIBarButtonItem *)sender {
    
}

- (IBAction)segmentedAction:(UISegmentedControl *)sender {
    [self loadRides];
}

// MARK: Custom methods
- (void) loadRides {
    NSString *rideType;
    
    switch (self.segmentedControl.selectedSegmentIndex) {
        case 0:
            rideType = @"Train";
            break;
        case 1:
            rideType = @"Bus";
            break;
        case 2:
            rideType = @"Flight";
            break;
        default:
            break;
    }
    
    void(^completion)(NSArray*) = ^void(NSArray* arrayIDs) {
        
        self.fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Ride"];
        self.fetchRequest.predicate = [NSPredicate predicateWithFormat:@"rideType.name = %@", rideType];
        self.fetchRequest.sortDescriptors = @[[[NSSortDescriptor alloc] initWithKey:@"departureTime" ascending:YES]]; // must get from sort button
        
        self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:self.fetchRequest
                                                                            managedObjectContext:[[CoreDataManager sharedInstance] mainObjectContext]
                                                                              sectionNameKeyPath:nil
                                                                                       cacheName:nil];
        [self.fetchedResultsController performFetch:nil];
        self.fetchedResultsController.delegate = self;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.tableView animated:YES];
            [self.tableView reloadData];
        });
    };
    
    [MBProgressHUD showHUDAddedTo:self.tableView animated:YES];
    [[RideManager sharedInstance] downloadRideData:rideType completion: completion];
}

- (void) configureCell:(UITableViewCell*) cell forIndexPath:(NSIndexPath*) indexPath {
    Ride *ride = nil;
    
    switch (indexPath.section) {
        case 0:
            [self.segmentedView removeFromSuperview];
            self.segmentedView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.segmentedView.frame.size.height);
            [cell.contentView addSubview:self.segmentedView];
            cell.accessoryType = UITableViewCellAccessoryNone;
            break;
            
        case 1:
            ride = [self.fetchedResultsController objectAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section-1]];
            ((RideTableViewCell*) cell).rideOID = ride.objectID;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            break;
    }
}

// MARK: UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 1;
        case 1:
            if (self.fetchRequest) {
                id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section-1];
                return sectionInfo.numberOfObjects;
                
            } else {
                return 0;
            }
        default:
            return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    
    switch (indexPath.section) {
        case 0:
            cell = [self.tableView dequeueReusableCellWithIdentifier:@"segmentedTableViewCell" forIndexPath:indexPath];
            break;
        case 1:
            cell = [self.tableView dequeueReusableCellWithIdentifier:@"rideTableViewCell" forIndexPath:indexPath];
            break;
    }
    
    [self configureCell:cell forIndexPath:indexPath];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

// MARK: UITableViewDelegate
- (nullable NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
            return nil;
        default:
            return indexPath;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return;
    }
    
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:@"Message"
                                  message:@"Offer details are not yet implemented!"
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"OK"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action) {
                             [alert dismissViewControllerAnimated:YES completion:nil];
                             
                         }];
    [alert addAction:ok];
    [self presentViewController:alert animated:YES completion:nil];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 1:
            return kRideTableViewCellHeight;
        default:
            return UITableViewAutomaticDimension;
    }
}

// MARK: NSFetchedResultsControllerDelegate
- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(nullable NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(nullable NSIndexPath *)newIndexPath {
    
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    
}

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    
}

@end

