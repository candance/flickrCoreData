//
//  FCDJustPostedFlickrPhotosVC.h
//  FlickrCoreData
//
//  Created by Candance Smith on 7/11/16.
//  Copyright © 2016 candance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface FCDJustPostedFlickrPhotosVC : UIViewController <NSFetchedResultsControllerDelegate>

// The controller (this class fetches nothing if this is not set).
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;

// Causes the fetchedResultsController to refetch the data.
// You almost certainly never need to call this.
// The NSFetchedResultsController class observes the context
//  (so if the objects in the context change, you do not need to call performFetch
//   since the NSFetchedResultsController will notice and update the table automatically).
// This will also automatically be called if you change the fetchedResultsController @property.
- (void)performFetch;

// Set to YES to get some debugging output in the console.
@property BOOL debug;

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
