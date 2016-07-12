//
//  FCDPhoto+CoreDataProperties.h
//  FlickrCoreData
//
//  Created by Candance Smith on 7/11/16.
//  Copyright © 2016 candance. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "FCDPhoto.h"

NS_ASSUME_NONNULL_BEGIN

@interface FCDPhoto (CoreDataProperties)

@property (nullable, nonatomic, retain) NSDate *date;
@property (nullable, nonatomic, retain) NSData *fullSizedImage;
@property (nullable, nonatomic, retain) NSString *identifier;
@property (nullable, nonatomic, retain) NSString *info;
@property (nullable, nonatomic, retain) NSData *thumbnailImage;
@property (nullable, nonatomic, retain) NSString *title;
@property (nullable, nonatomic, retain) FCDPlace *photoPlace;

@end

NS_ASSUME_NONNULL_END
