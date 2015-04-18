//
//  ViewController.m
//  CleanMePlease
//
//  Created by Layne Moseley on 4/16/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import "ViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic)          NSArray     *data;
@property (nonatomic) IBOutlet UITableView *tableView;

@end


@implementation ViewController

#pragma mark -
#pragma mark ViewController Methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self fetchData];
}

#pragma mark - Private Methods

// Fetches data from the api and reloads the table view when finished
- (void)fetchData
{
    NSURL *url = [NSURL URLWithString:@"http://jsonplaceholder.typicode.com/photos"];
    
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if (error) {
            [self handleError:error];
            return;
        }
        
        id jsonObjects = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        
        if (error) {
            [self handleError:error];
            return;
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.data = jsonObjects;
            [self.tableView reloadData];
        });
    }];
    
    [dataTask resume];
}

- (void)handleError:(NSError *)error {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oops!" message:error.localizedDescription delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
    [alert show];
}

#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.data count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell        = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    NSDictionary    *data        = self.data[indexPath.row];
    NSURL           *imageUrl    = [NSURL URLWithString:data[@"thumbnailUrl"]];
    UIImage         *placeholder = [UIImage imageNamed:@"eeeeee.gif"];
    
    cell.textLabel.text = data[@"title"];
    
    [cell.imageView sd_setImageWithURL:imageUrl placeholderImage:placeholder];
    
    return cell;
}

@end
