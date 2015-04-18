//
//  ViewController.m
//  CleanMePlease
//
//  Created by Layne Moseley on 4/16/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic) NSArray *data;
@property (nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSURLResponse *response = nil;
    NSError *error = nil;
    
    NSArray *jsonObjects = [NSJSONSerialization JSONObjectWithData:[NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://jsonplaceholder.typicode.com/photos"]] returningResponse:&response error:&error] options:0 error:nil];
    
    self.data = jsonObjects;
    
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.data count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.textLabel.text = self.data[indexPath.row][@"title"];
    cell.imageView.image = [UIImage imageWithData:[NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.data[indexPath.row][@"thumbnailUrl"]]] returningResponse:nil error:nil]];
    
    return cell;
}









@end
