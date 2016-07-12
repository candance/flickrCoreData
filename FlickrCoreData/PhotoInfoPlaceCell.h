//
//  PhotoInfoPlaceCell.h
//  FlickrCoreData
//
//  Created by Candance Smith on 7/11/16.
//  Copyright © 2016 candance. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoInfoPlaceCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *photoTitle;
@property (weak, nonatomic) IBOutlet UILabel *photoCity;
@property (weak, nonatomic) IBOutlet UILabel *photoCountry;
@property (weak, nonatomic) IBOutlet UILabel *photoDate;
@property (weak, nonatomic) IBOutlet UIImageView *photoThumbnail;

@end
