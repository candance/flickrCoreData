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

- (void)performFetch;

// Set to YES to get some debugging output in the console.
@property BOOL debug;

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
