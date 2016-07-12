//
//  FCDPlace.h
//  FlickrCoreData
//
//  Created by Candance Smith on 7/11/16.
//  Copyright © 2016 candance. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class FCDPhoto;

NS_ASSUME_NONNULL_BEGIN

@interface FCDPlace : NSManagedObject

// Insert code here to declare functionality of your managed object subclass
+ (FCDPlace *)placeWithID:(NSString *)placeID
   inManagedObjectContext:(NSManagedObjectContext *)context;

@end

NS_ASSUME_NONNULL_END

#import "FCDPlace+CoreDataProperties.h"
