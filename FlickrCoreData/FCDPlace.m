//
//  FCDPlace.m
//  FlickrCoreData
//
//  Created by Candance Smith on 7/11/16.
//  Copyright © 2016 candance. All rights reserved.
//

#import "FCDPlace.h"
#import "FCDPhoto.h"

@implementation FCDPlace

// Insert code here to add functionality to your managed object subclass
+ (FCDPlace *)placeWithID:(NSString *)placeID
     inManagedObjectContext:(NSManagedObjectContext *)context {
    
    FCDPlace *place = nil;
    
    if ([placeID length]) {
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Place"];
        request.predicate = [NSPredicate predicateWithFormat:@"placeID = %@", placeID];
    
        NSError *error;
        NSArray *matches = [context executeFetchRequest:request error:&error];
        
        if (!matches || error || ([matches count] > 1)) {
            // handle error
        } else if (![matches count]) { // match = 0, create photo object
            place = [NSEntityDescription insertNewObjectForEntityForName:@"Place" inManagedObjectContext:context];
            
            place.placeID = placeID;
            
        } else { // there's a match
            place = [matches firstObject];
        }
    }
        return place;
    
}


@end
