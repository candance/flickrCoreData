//
//  FCDPhoto.m
//  FlickrCoreData
//
//  Created by Candance Smith on 7/11/16.
//  Copyright © 2016 candance. All rights reserved.
//

#import "FCDPhoto.h"
#import "FCDPlace.h"
#import "FlickrFetcher.h"

@implementation FCDPhoto

// Insert code here to add functionality to your managed object subclass

+ (FCDPhoto *)photoWithFlickrInfo:(NSDictionary *)photoDictionary
           inManagedObjectContext:(NSManagedObjectContext *)context {
    
    FCDPhoto *photo = nil;
    
    NSString *identifier = [photoDictionary valueForKeyPath:FLICKR_PHOTO_ID];
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Photo"];
    request.predicate = [NSPredicate predicateWithFormat:@"identifier = %@", identifier];
    
    NSError *error;
    NSArray *matches = [context executeFetchRequest:request error:&error];
    
//     if match is nil or if there's an error or if there's more than 1 match
    if (!matches || error || ([matches count] > 1)) {
        // handle error
    } else if ([matches count]) { // there's a match
        photo = [matches firstObject];
    } else { // match = 0, create photo object
        photo = [NSEntityDescription insertNewObjectForEntityForName:@"Photo" inManagedObjectContext:context];
        
        photo.identifier = identifier;
        photo.title = [photoDictionary valueForKeyPath:FLICKR_PHOTO_TITLE];
        photo.info = [photoDictionary valueForKeyPath:FLICKR_PHOTO_DESCRIPTION];
        
        NSNumber *date = [NSNumber numberWithInteger:[[photoDictionary valueForKeyPath:FLICKR_PHOTO_UPLOAD_DATE] integerValue]];
        photo.date = [NSDate dateWithTimeIntervalSince1970:[date doubleValue]];
        photo.thumbnailImage = [NSData dataWithContentsOfURL:[FlickrFetcher URLforPhoto:photoDictionary format:FlickrPhotoFormatSquare]];
        photo.fullSizedImage = [NSData dataWithContentsOfURL:[FlickrFetcher URLforPhoto:photoDictionary format:FlickrPhotoFormatLarge]];
        
        NSString *placeID = [photoDictionary valueForKeyPath:FLICKR_PHOTO_PLACE_ID];
        photo.photoPlace = [FCDPlace placeWithID:placeID inManagedObjectContext:context];
    }
    
    return photo;
}


@end
