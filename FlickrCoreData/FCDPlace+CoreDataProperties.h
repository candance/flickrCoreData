//
//  FCDPlace+CoreDataProperties.h
//  FlickrCoreData
//
//  Created by Candance Smith on 7/11/16.
//  Copyright © 2016 candance. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "FCDPlace.h"

NS_ASSUME_NONNULL_BEGIN

@interface FCDPlace (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *city;
@property (nullable, nonatomic, retain) NSString *country;
@property (nullable, nonatomic, retain) NSString *placeID;
@property (nullable, nonatomic, retain) NSSet<FCDPhoto *> *placePhoto;

@end

@interface FCDPlace (CoreDataGeneratedAccessors)

- (void)addPlacePhotoObject:(FCDPhoto *)value;
- (void)removePlacePhotoObject:(FCDPhoto *)value;
- (void)addPlacePhoto:(NSSet<FCDPhoto *> *)values;
- (void)removePlacePhoto:(NSSet<FCDPhoto *> *)values;

@end

NS_ASSUME_NONNULL_END
