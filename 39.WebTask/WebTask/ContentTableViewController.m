//
//  ContentTableViewController.m
//  WebTask
//
//  Created by Aleksandr on 14/12/2019.
//  Copyright © 2019 Aleksandr Shushkov. All rights reserved.
//

#import "ContentTableViewController.h"
#import "ContentSources.h"
#import "ViewController.h"

@interface ContentTableViewController () <UITableViewDelegate>

@property (strong, nonatomic) ContentSources *source;

@end

@implementation ContentTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.source = [ContentSources new];
    self.navigationItem.title = @"Select content";
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return @"Web";
            break;
        case 1:
            return @"PDF";
            break;
        default:
            break;
    }
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSDictionary *dictionary = [self dictionaryForSection:section];
    if (dictionary) {
        return dictionary.count;
    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"defaultIdentifier" forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"defaultIdentifier"];
    }
    
    NSDictionary *dictionary = [self dictionaryForSection:indexPath.section];
    NSArray<NSString *> *keys = [dictionary allKeys];
    cell.textLabel.text = keys[indexPath.row];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dictonary = [self dictionaryForSection:indexPath.section];
    NSArray<NSString *> *keys = [dictonary allKeys];
    NSString *selectedKey = keys[indexPath.row];
    
    ViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
    vc.address = dictonary[selectedKey];
    
    [self.navigationController pushViewController:vc animated:YES];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Utility

- (NSDictionary *)dictionaryForSection:(NSInteger)section {
    switch (section) {
        case 0:
            return self.source.web;
            break;
        case 1:
            return self.source.pdf;
            break;
        default:
            break;
    }
    return nil;
}

@end
