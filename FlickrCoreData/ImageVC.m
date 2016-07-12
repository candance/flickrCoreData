//
//  ImageVC.m
//  FlickrCoreData
//
//  Created by Candance Smith on 7/11/16.
//  Copyright © 2016 candance. All rights reserved.
//

#import "ImageVC.h"

@interface ImageVC ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ImageVC

-(void)viewDidLoad {
    [super viewDidLoad];
    
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    spinner.center = CGPointMake(self.view.frame.size.width * 0.5, self.view.frame.size.height * 0.5);
    [self.view addSubview:spinner];
    [self.view bringSubviewToFront:spinner];
    spinner.hidesWhenStopped = YES;
    spinner.hidden = NO;
    
    [spinner startAnimating];

    self.imageView.image = self.image;
    
    [spinner stopAnimating];
}

@end
