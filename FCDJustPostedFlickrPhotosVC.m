//
//  FCDJustPostedFlickrPhotosVC.m
//  FlickrCoreData
//
//  Created by Candance Smith on 7/11/16.
//  Copyright © 2016 candance. All rights reserved.
//

#import "FCDJustPostedFlickrPhotosVC.h"
#import "FlickrFetcher.h"
#import "PhotoInfoPlaceCell.h"
#import "FCDPhoto.h"
#import "ImageVC.h"

@interface FCDJustPostedFlickrPhotosVC () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation FCDJustPostedFlickrPhotosVC

-(void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self fetchPhotos];
}

// making a web request
- (void)fetchPhotos {
    
    NSURL *url = [FlickrFetcher URLforRecentGeoreferencedPhotos];
    
    // unblocking main queue through multithreading
    dispatch_queue_t fetchQ = dispatch_queue_create("flickr places fetcher", NULL);
    dispatch_sync(fetchQ, ^{
        NSData *jsonResults = [NSData dataWithContentsOfURL:url];
        NSDictionary *photosResults = [NSJSONSerialization JSONObjectWithData:jsonResults
                                                                      options:0
                                                                        error:NULL];
        
        //        NSLog(@"Photos Results:%@", photosResults);
        
        NSArray *photos = [photosResults valueForKeyPath:FLICKR_RESULTS_PHOTOS];

        dispatch_async(dispatch_get_main_queue(), ^{
            for (NSDictionary *photo in photos) {
                [FCDPhoto photoWithFlickrInfo:photo inManagedObjectContext:self.managedObjectContext];
            }
            [self.managedObjectContext save:NULL];
            [self performFetch];
            
        });
    });
}

#pragma mark - Fetching

- (void)performFetch
{
    // Initialize Fetch Request
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Photo"];
    
    [fetchRequest setFetchLimit:30];
    
    // Add Sort Descriptors
    [fetchRequest setSortDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"date" ascending:YES]]];
    
    // Initialize Fetched Results Controller
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    
    // Configure Fetched Results Controller
    [self.fetchedResultsController setDelegate:self];
    
    // Perform Fetch
    NSError *error = nil;
    [self.fetchedResultsController performFetch:&error];
    
    if (error) {
        NSLog(@"Unable to perform fetch.");
        NSLog(@"%@, %@", error, error.localizedDescription);
    }
    
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"Photo Info Place Cell";
    PhotoInfoPlaceCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    FCDPhoto *photo = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    NSCharacterSet *set = [NSCharacterSet whitespaceCharacterSet];
    if ([[photo.title stringByTrimmingCharactersInSet:set] length]) {
        cell.photoTitle.text = photo.title;
    } else {
        cell.photoTitle.text = @"Unknown";

    }
    cell.photoCity.text = @"City: Mewtown";
    cell.photoCountry.text = @"Country: Mewlaysia";
    cell.photoDate.text = [NSString stringWithFormat:@"Date: %@", photo.date];
    cell.photoThumbnail.image = [UIImage imageWithData:photo.thumbnailImage];
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSInteger sections = [[self.fetchedResultsController sections] count];
    return sections;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger rows = 0;
    if ([[self.fetchedResultsController sections] count] > 0) {
        id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
        rows = [sectionInfo numberOfObjects];
    }
    return rows;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [[[self.fetchedResultsController sections] objectAtIndex:section] name];
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    return [self.fetchedResultsController sectionForSectionIndexTitle:title atIndex:index];
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return [self.fetchedResultsController sectionIndexTitles];
}

#pragma mark - NSFetchedResultsControllerDelegate

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller
  didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex
     forChangeType:(NSFetchedResultsChangeType)type
{
    switch(type)
    {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}


- (void)controller:(NSFetchedResultsController *)controller
   didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath
     forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath
{
    switch(type)
    {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeMove:
            [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView endUpdates];
}

#pragma mark - segue

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"Display Photo" sender:indexPath];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"Display Photo"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        FCDPhoto *photo = [self.fetchedResultsController objectAtIndexPath:indexPath];
        ImageVC *ivc = [segue destinationViewController];
        ivc.image = [UIImage imageWithData:photo.fullSizedImage];
    }
}

@end