//
//  FCDPhoto.h
//  FlickrCoreData
//
//  Created by Candance Smith on 7/11/16.
//  Copyright © 2016 candance. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class FCDPlace;

NS_ASSUME_NONNULL_BEGIN

@interface FCDPhoto : NSManagedObject

// Insert code here to declare functionality of your managed object subclass

+ (FCDPhoto *)photoWithFlickrInfo:(NSDictionary *)photoDictionary
           inManagedObjectContext:(NSManagedObjectContext *)context;

@end

NS_ASSUME_NONNULL_END

#import "FCDPhoto+CoreDataProperties.h"
